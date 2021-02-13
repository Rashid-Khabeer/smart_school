import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/lesson-plan_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/pages/lesson-plan-detail_page.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/nav.dart';
import 'package:smart_school/src/utility/utils.dart';
import 'package:toast/toast.dart';

class LessonPlanPage extends StatefulWidget {
  @override
  _LessonPlanPageState createState() => _LessonPlanPageState();
}

class _LessonPlanPageState extends State<LessonPlanPage> {
  DateTime _firstDate, _lastDate;

  bool _isLoading = true;
  LessonPlan _lessonPlan = LessonPlan();

  _getData() async {
    ServerError _error;
    _lessonPlan = await RestService()
        .getLessonPlans(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: LessonPlanRequest(
        studentId: AppData().readLastUser().studentRecord.studentId,
        dateFrom: DateFormat('yyyy-MM-dd').format(_firstDate).toString(),
        datTo: DateFormat('yyyy-MM-dd').format(_lastDate).toString(),
      ),
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

  @override
  void initState() {
    super.initState();
    _firstDate =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    _lastDate = _firstDate.add(Duration(days: 6));
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Plan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Column(
            children: [
              _DateSlider(
                firstDate: _firstDate,
                lastDate: _lastDate,
                onChanged: (first, last) {
                  _firstDate = first;
                  _lastDate = last;
                  _isLoading = true;
                  setState(() {});
                  _getData();
                },
              ),
              _isLoading
                  ? LoadingWidget()
                  : Column(
                      children: [
                        _RowItem(
                          firstDate: _firstDate,
                          lessonDays:
                              _lessonPlan?.lessonWeeks?.sundayList ?? [],
                        ),
                        _RowItem(
                          firstDate: _firstDate.add(Duration(days: 1)),
                          lessonDays:
                              _lessonPlan?.lessonWeeks?.mondayList ?? [],
                        ),
                        _RowItem(
                          firstDate: _firstDate.add(Duration(days: 2)),
                          lessonDays:
                              _lessonPlan?.lessonWeeks?.tuesdayList ?? [],
                        ),
                        _RowItem(
                          firstDate: _firstDate.add(Duration(days: 3)),
                          lessonDays:
                              _lessonPlan?.lessonWeeks?.wednesdayList ?? [],
                        ),
                        _RowItem(
                          firstDate: _firstDate.add(Duration(days: 4)),
                          lessonDays:
                              _lessonPlan?.lessonWeeks?.thursdayList ?? [],
                        ),
                        _RowItem(
                          firstDate: _firstDate.add(Duration(days: 5)),
                          lessonDays:
                              _lessonPlan?.lessonWeeks?.fridayList ?? [],
                        ),
                        _RowItem(
                          firstDate: _firstDate.add(Duration(days: 6)),
                          lessonDays:
                              _lessonPlan?.lessonWeeks?.saturdayList ?? [],
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final firstDate;
  final List<LessonDays> lessonDays;

  _RowItem({this.firstDate, this.lessonDays});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Utils.getWeekOfDay(firstDate.weekday),
                  style: k14Style,
                ),
                Text(
                  DateFormat('MM/dd/yyyy').format(firstDate).toString(),
                  style: k14Style,
                ),
              ],
            ),
          ),
          if (lessonDays.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subject', style: k16BoldStyle),
                  Text('Time', style: k16BoldStyle),
                  Text('Syllabus', style: k16BoldStyle),
                ],
              ),
            ),
          ListView.builder(
            itemCount: lessonDays.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              LessonDays _day = lessonDays[index];
              final _time = _day.timeFrom.isNotEmpty
                  ? '${_day.timeFrom}-${_day.timeTo}'
                  : '';
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${_day.name} ${_day.code.isNotEmpty ? '(${_day.code})' : ''}",
                      style: k14SimpleStyle,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          _time,
                          style: k14SimpleStyle,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(CupertinoIcons.info_circle_fill),
                      onPressed: () => AppNavigation.to(
                        context,
                        LessonPlanDetailPage(lessonDays: _day),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DateSlider extends StatefulWidget {
  final DateTime firstDate, lastDate;
  final Function(DateTime firstDate, DateTime secondDate) onChanged;

  _DateSlider({
    this.onChanged,
    this.lastDate,
    this.firstDate,
  });

  @override
  __DateSliderState createState() => __DateSliderState();
}

class __DateSliderState extends State<_DateSlider> {
  DateTime _firstDate, _lastDate;

  @override
  void initState() {
    super.initState();
    _firstDate = widget.firstDate;
    _lastDate = widget.lastDate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () => _change(-7),
        ),
        Text(
          DateFormat('MM/dd/yyyy').format(_firstDate).toString(),
          style: k14Style,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            '-',
            style: k14Style,
          ),
        ),
        Text(
          DateFormat('MM/dd/yyyy').format(_lastDate).toString(),
          style: k14Style,
        ),
        IconButton(
          icon: Icon(CupertinoIcons.chevron_forward),
          onPressed: () => _change(7),
        ),
      ],
    );
  }

  _change(int day) {
    _firstDate = _firstDate.add(Duration(days: day));
    _lastDate = _lastDate.add(Duration(days: day));
    widget.onChanged(_firstDate, _lastDate);
    setState(() {});
  }
}
