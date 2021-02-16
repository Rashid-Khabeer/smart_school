import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/hostel_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/hostel-bottom_sheet.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:toast/toast.dart';

class HostelPage extends StatefulWidget {
  @override
  _HostelPageState createState() => _HostelPageState();
}

class _HostelPageState extends State<HostelPage> {
  bool _isLoading = true;
  Hostel _hostel = Hostel();

  _getData() async {
    ServerError _error;
    _hostel = await RestService()
        .getHostel(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
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
          title: Text(lang.hostel),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _hostel?.data?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _hostel?.data?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          data: _hostel.data[index],
                          lang: lang,
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final HostelData data;
  final AppLocalizations lang;

  _RowItem({this.data, this.lang});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.bed_double),
                SizedBox(width: 10),
                Text(data.hostelName),
                Spacer(),
                TextButton.icon(
                  onPressed: () {
                    Scaffold.of(context).showBottomSheet(
                      (context) => HostelBottomSheet(
                        id: data.id,
                        title: data.hostelName,
                      ),
                    );
                  },
                  icon: Icon(CupertinoIcons.list_number),
                  label: Text(lang.view),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
