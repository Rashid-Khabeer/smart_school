import 'package:flutter/material.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
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

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: kMainColor,
        todayColor: kMainColor,
        outsideDaysVisible: false,
      ),
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
      onCalendarCreated: (first, second, format) {
        _calendarController.setSelectedDay(DateTime(2021, 2, 13));
      },
    );
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
