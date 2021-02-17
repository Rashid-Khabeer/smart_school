import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/attendance_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toast/toast.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  CalendarController _calendarController;
  bool _isLoading = true;

  _getData(DateTime date) async {
    ServerError _error;
    final _attendance = await RestService()
        .getAttendance(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: AttendanceRequest(
        studentId: AppData().readLastUser().studentRecord.studentId,
        month: date.month.toString(),
        year: date.year.toString(),
      ),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, context);
      _isLoading = true;
    });
    if (_error == null) {
      //   DateTime(2021, 2, 1): ['New Year\'s Day'],
      _attendance.data.forEach((element) {
        _holidays.addAll({
          DateTime.parse(element.date): [element.type.toString()]
        });
      });
    }
    setState(() {});
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _getData(DateTime.now());
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Map<DateTime, List> _holidays = {};

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      onVisibleDaysChanged: (first, second, format) {
        print('Changed');
        _isLoading = true;
        _holidays.clear();
        setState(() {});
        _getData(first);
      },
      calendarStyle: CalendarStyle(
        selectedColor: kMainColor,
        todayColor: kMainColor,
        outsideDaysVisible: false,
      ),
      holidays: _holidays,
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(
          color: Colors.white,
          fontSize: 15.0,
        ),
        formatButtonVisible: false,
        formatButtonDecoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      builders: CalendarBuilders(
        markersBuilder: (ctx, date, events, holidays) {
          return holidays
              .map(
                (e) => Positioned(
                  right: 18,
                  top: 32,
                  child: Icon(
                    FontAwesome.circle,
                    size: 15.0,
                    color: _getColor(e.toString()),
                  ),
                ),
              )
              .toList();
        },
      ),
    );
  }

  _getColor(String type) {
    switch (type) {
      case 'Present':
        return Colors.green;
      case 'Late':
        return Colors.yellow;
      case 'Holiday':
        return Colors.grey;
      case 'Absent':
        return Colors.red;
      case 'Half Day':
        return Colors.orange;
      default:
        return kMainColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => Scaffold(
        appBar: AppBar(
          title: Text(lang.attendance),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (_isLoading) LoadingWidget(),
              _buildTableCalendar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _RowItem(
                      color: Colors.green,
                      title: 'Present',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _RowItem(
                        color: Colors.red,
                        title: 'Absent',
                      ),
                    ),
                    _RowItem(
                      color: Colors.yellow,
                      title: 'Late',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _RowItem(
                      color: Colors.orange,
                      title: 'Half Day',
                    ),
                    SizedBox(width: 20.0),
                    _RowItem(
                      color: Colors.grey,
                      title: 'Holiday',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final color;
  final title;

  _RowItem({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25.0,
          width: 25.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Text(title, style: k14Style),
      ],
    );
  }
}

class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
