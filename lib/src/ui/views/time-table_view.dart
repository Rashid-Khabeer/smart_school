import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/data/models/time-table_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class TimeTableView extends StatefulWidget {
  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  bool _isLoading = true;
  TimeTable _timeTable = TimeTable();

  _getData() async {
    ServerError _error;
    _timeTable = await RestService()
        .getTimeTable(
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
  }

  Future<void> _fetchData() async => await _getData();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingWidget();
    } else {
      return LocalizedView(
        builder: (ctx, lang) => RefreshIndicator(
          onRefresh: _fetchData,
          child: _timeTable?.timeWeek ?? null== null
              ? NoDataWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _RowItem(
                        day: lang.sunday,
                        list: _timeTable.timeWeek.sunday,
                      ),
                      _RowItem(
                        day: lang.monday,
                        list: _timeTable.timeWeek.monday,
                      ),
                      _RowItem(
                        day: lang.tuesday,
                        list: _timeTable.timeWeek.tuesday,
                      ),
                      _RowItem(
                        day: lang.wednesday,
                        list: _timeTable.timeWeek.wednesday,
                      ),
                      _RowItem(
                        day: lang.thursday,
                        list: _timeTable.timeWeek.thursday,
                      ),
                      _RowItem(
                        day: lang.friday,
                        list: _timeTable.timeWeek.friday,
                      ),
                      _RowItem(
                        day: lang.saturday,
                        list: _timeTable.timeWeek.saturday,
                      ),
                    ],
                  ),
                ),
        ),
      );
    }
  }
}

class _RowItem extends StatelessWidget {
  final List<Days> list;
  final String day;

  _RowItem({this.list, this.day});

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.grey.shade300,
              child: Text(day, style: k16BoldStyle),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text(lang.time, style: k16BoldStyle)),
                    DataColumn(label: Text(lang.subject, style: k16BoldStyle)),
                    DataColumn(label: Text(lang.roomNo, style: k16BoldStyle)),
                  ],
                  rows: list?.isNotEmpty ?? false ? _getDataRow() : [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getDataRow() {
    return list.map((e) {
      print(e.subjectName);
      print(e.code);
      return DataRow(
        cells: [
          DataCell(
            Text(
              e.timeFrom != ''
                  ? '${e.timeFrom} - \n${e.timeTo}'
                  : 'Not Scheduled',
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              '${e.subjectName} ${e.code == '' ? '' : '(${e.code})'}',
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              e.roomNo,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
        ],
      );
    }).toList();
  }
}
