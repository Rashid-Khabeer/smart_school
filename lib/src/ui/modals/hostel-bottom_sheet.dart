import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/hostel_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class HostelBottomSheet extends StatefulWidget {
  final String id;
  final String title;

  HostelBottomSheet({this.id, this.title});

  @override
  _HostelBottomSheetState createState() => _HostelBottomSheetState();
}

class _HostelBottomSheetState extends State<HostelBottomSheet> {
  bool _isLoading = true;

  HostelDetail _detail = HostelDetail();

  _fetchData() async {
    _detail = await RestService()
        .getHostelDetail(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: HostelDetailRequest(
        hostelId: widget.id,
        studentId: AppData().readLastUser().studentRecord.studentId,
      ),
    )
        .catchError((error) {
          print(error);
      // Toast.show(ServerError.withError(error).errorMessage, context);
      _isLoading = true;
    });
    setState(() {});
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: k16BoldStyle),
                IconButton(
                  icon: Icon(CupertinoIcons.clear),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          _isLoading
              ? LoadingWidget()
              : _detail?.data?.isEmpty ?? true
                  ? NoDataWidget()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: DataTable(
                          columns: [
                            DataColumn(
                                label: Text('Room Type', style: k14Style)),
                            DataColumn(
                                label: Text('No of Bed', style: k14Style)),
                            DataColumn(label: Text('Room No', style: k14Style)),
                            DataColumn(
                                label: Text('Room Cost', style: k14Style)),
                          ],
                          rows: _detail?.data?.isNotEmpty ?? false
                              ? _getDataRow(_detail.data)
                              : [],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  _getDataRow(List<HostelDetailData> data) {
    return data.map((e) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              e.roomType,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              e.noOfBed,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              e.roomNo,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
            'IQD ${e.costPerBed}',
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
        ],
      );
    }).toList();
  }
}
