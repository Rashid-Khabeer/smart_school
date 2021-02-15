import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/examination_model.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/pages/exam-schedule_page.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/nav.dart';
import 'package:toast/toast.dart';

class ExaminationPage extends StatefulWidget {
  @override
  _ExaminationPageState createState() => _ExaminationPageState();
}

class _ExaminationPageState extends State<ExaminationPage> {
  bool _isLoading = true;
  Examination _examination = Examination();

  _getData() async {
    ServerError _error;
    print(AppData().readLastUser().studentRecord.studentId);
    _examination = await RestService()
        .getExamination(
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
    return LocalizedView(
      builder: (ctx, lang) => Scaffold(
        appBar: AppBar(
          title: Text(lang.examination),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _examination?.detail?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _examination?.detail?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          data: _examination.detail[index],
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final ExaminationDetail data;

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
                Icon(FontAwesome.newspaper_o),
                SizedBox(width: 20),
                Text(data.exam, style: k16BoldStyle),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (data.resultPublish != '0')
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.request_page,
                    color: kMainColor,
                  ),
                  label: Text('Exam Result'),
                ),
              TextButton.icon(
                onPressed: () => AppNavigation.to(
                  context,
                  ExamSchedulePage(
                    examGroupId: data.examId,
                  ),
                ),
                icon: Icon(
                  CupertinoIcons.clock,
                  color: kMainColor,
                ),
                label: Text('Exam Schedule'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
