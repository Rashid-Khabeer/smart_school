import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/fee_model.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class FeesPage extends StatefulWidget {
  @override
  _FeesPageState createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  bool _isLoading = true;
  Fee _fee = Fee();
  List<FeeDetail> _list = [];

  _getData() async {
    ServerError _error;
    _fee = await RestService()
        .getFee(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request:
          StudentRequest(id: AppData().getUserId()),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, context);
      _isLoading = true;
    });
    setState(() {});
    _isLoading = false;
    _list.clear();
    _fee.studentDueFee.forEach((element) => _list.addAll(element.feeDetails));
  }

  Future<void> _fetchData() async => await _getData();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => Scaffold(
        appBar: AppBar(
          title: Text(lang.fee),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: Container(
              color: Colors.white,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.grey.shade300,
                      padding: EdgeInsets.all(5.0),
                      child: Text(lang.grandTotal, style: k16BoldStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                                "${lang.amount}\n\$${_fee.grandFee?.amount ?? ''}",
                                style: k14Style),
                          ),
                          Expanded(
                            child: Text(
                                "${lang.discount}\n\$${_fee.grandFee?.amountDiscount ?? ''}",
                                style: k14Style),
                          ),
                          Expanded(
                            child: Text(
                                "${lang.fine}\n\$${_fee.grandFee?.amountFine ?? ''}",
                                style: k14Style),
                          ),
                          Expanded(
                            child: Text(
                                "${lang.paid}\n\$${_fee.grandFee?.amountPaid ?? ''}",
                                style: k14Style),
                          ),
                          Expanded(
                            child: Text(
                                "${lang.balance}\n\$${_fee.grandFee?.amountRemaining ?? ''}",
                                style: k14Style),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _list?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _list?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          feeDetail: _list[index],
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final FeeDetail feeDetail;

  _RowItem({this.feeDetail});

  _checkDate(String date) {
    DateTime dueDate = DateTime.parse(date);
    DateTime today = DateTime.now();
    if (today.isAfter(dueDate))
      return Colors.red;
    else
      return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    Color _color, _textColor;
    Color _containerColor;
    if (feeDetail.status == 'paid') {
      _color = Colors.green;
      _textColor = Colors.white;
    } else if (feeDetail.status == 'unpaid') {
      _color = Colors.red;
      _textColor = Colors.black;
      _containerColor = _checkDate(feeDetail.dueDate);
    } else if (feeDetail.status == 'partial') {
      _color = Colors.yellow;
      _textColor = Colors.black;
      _containerColor = _checkDate(feeDetail.dueDate);
    }
    return LocalizedView(
      builder: (ctx, lang) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        lang.dueDate,
                        style: k14Style,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 65.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 5.0),
                        color: _containerColor,
                        child: Text(
                          feeDetail.dueDate,
                          style: k14Style.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 5.0),
                        color: _color,
                        child: Text(
                          feeDetail.status,
                          style: k14Style.copyWith(color: _textColor),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      "${lang.amount}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\$${feeDetail.amount}",
                      style: k14Style,
                    ),
                  ),
                  Text(
                    "${lang.paidAmount}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\$${feeDetail.totalAmountPaid}",
                    style: k14Style,
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    "${lang.balanceAmount}\t\t\t\t\t\t\t\t\$${feeDetail.totalAmountRemaining}",
                    style: k14Style,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
