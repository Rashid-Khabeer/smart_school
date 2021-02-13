import 'package:flutter/material.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              calendarController: _calendarController,
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
