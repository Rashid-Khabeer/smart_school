import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/examination_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class ExamSchedulePage extends StatefulWidget {
  final String examGroupId;

  ExamSchedulePage({this.examGroupId});

  @override
  _ExamSchedulePageState createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  bool _isLoading = true;
  ExamSchedule _schedule = ExamSchedule();

  _getData() async {
    ServerError _error;
    _schedule = await RestService()
        .getExamSchedule(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: ExamScheduleRequest(id: widget.examGroupId),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: _isLoading
          ? LoadingWidget()
          : RefreshIndicator(
              onRefresh: _fetchData,
              child: _schedule?.detail?.isEmpty ?? true
                  ? NoDataWidget()
                  : ListView.builder(
                      itemCount: _schedule?.detail?.length ?? 0,
                      itemBuilder: (context, index) => _RowItem(
                        data: _schedule.detail[index],
                      ),
                    ),
            ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final ExamScheduleDetail data;

  _RowItem({this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Icon(FontAwesome.book),
                SizedBox(width: 20),
                Text(
                  '${data.subjectName} (${data.subjectCode})',
                  style: k16BoldStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                item('Date', data.dateFrom, Icons.date_range),
                item('Room No', data.roomNo, Icons.room),
                item('Start Time', data.timeFrom, Icons.timer),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                item('Duration', data.duration, FontAwesome5.clock),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Max Marks\n${data.maxMarks}',
                    style: k14Style,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Min Marks\n${data.minMarks}',
                    style: k14Style,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Credit Hours\n${data.creditHours}',
                    style: k14Style,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget item(String title, String text, IconData icon) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: k14Style),
                SizedBox(height: 5),
                Text(text, style: k14Style),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
