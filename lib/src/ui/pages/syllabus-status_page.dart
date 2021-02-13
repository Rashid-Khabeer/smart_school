import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/data/models/student-syllabus_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/pages/syllabus-status-detail_page.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/nav.dart';
import 'package:toast/toast.dart';

class SyllabusStatusPage extends StatefulWidget {
  @override
  _SyllabusStatusPageState createState() => _SyllabusStatusPageState();
}

class _SyllabusStatusPageState extends State<SyllabusStatusPage> {
  bool _isLoading = true;
  Syllabus _syllabus = Syllabus();

  _getData() async {
    ServerError _error;
    print(AppData().readLastUser().studentRecord.studentId);
    _syllabus = await RestService()
        .getSyllabus(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request:
          StudentRequest(id: AppData().readLastUser().studentRecord.studentId),
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
        title: Text('Syllabus Status'),
      ),
      body: _isLoading
          ? LoadingWidget()
          : RefreshIndicator(
              onRefresh: _fetchData,
              child: _syllabus?.syllabusStatus?.isEmpty ?? true
                  ? NoDataWidget()
                  : ListView.builder(
                      itemCount: _syllabus.syllabusStatus?.length ?? 0,
                      itemBuilder: (context, index) => _RowItem(
                        syllabusStatus: _syllabus.syllabusStatus[index],
                      ),
                    ),
            ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final SyllabusStatus syllabusStatus;

  _RowItem({this.syllabusStatus});

  @override
  Widget build(BuildContext context) {
    final _totalComplete = double.parse(syllabusStatus.totalComplete);
    final _total = double.parse(syllabusStatus.total);
    var _complete;
    var _completePercentage;
    if (_total != 0) {
      _complete = (_totalComplete / _total);
      _completePercentage = (_complete * 100.0).round();
    } else {
      _complete = 0;
      _completePercentage = 0;
    }
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
              left: 10.0,
              right: 5.0,
            ),
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Icon(CupertinoIcons.book),
                Text(
                  "${syllabusStatus.subjectName} ${syllabusStatus.subjectCode.isEmpty ? '' : (syllabusStatus.subjectCode)} ",
                  style: k16BoldStyle,
                ),
                Spacer(),
                Text(
                  "${_completePercentage.toString()}% Completed",
                  style: k16BoldStyle,
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () {
              AppNavigation.to(
                context,
                SyllabusStatusDetailPage(syllabusStatus: syllabusStatus),
              );
            },
            icon: Icon(CupertinoIcons.list_number),
            label: Text('Lesson Topic'),
          ),
        ],
      ),
    );
  }
}
