import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/online-exam_model.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class OnlineExamPage extends StatefulWidget {
  @override
  _OnlineExamPageState createState() => _OnlineExamPageState();
}

class _OnlineExamPageState extends State<OnlineExamPage> {
  bool _isLoading = true;
  OnlineExam _onlineExam = OnlineExam();

  _getData() async {
    ServerError _error;
    _onlineExam = await RestService()
        .getOnlineExam(
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
          title: Text(lang.exam),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _onlineExam?.exams?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _onlineExam?.exams?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          exam: _onlineExam.exams[index],
                          lang: lang,
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final Exam exam;
  final AppLocalizations lang;

  _RowItem({this.exam, this.lang});

  @override
  Widget build(BuildContext context) {
    String status = '';
    // bool _view;
    bool _exam;
    if (exam.publishResult == '1') {
      status = lang.statusPublished;
      // _view = true;
      _exam = false;
    } else {
      // _view = false;
      status = lang.available;
      if (exam.isSubmitted == '1')
        _exam = false;
      else
        _exam = true;
    }
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    exam?.exam ?? '',
                    style: k16BoldStyle,
                  ),
                ),
                _exam
                    ? TextButton.icon(
                        onPressed: () {
                          // Scaffold.of(context).showBottomSheet(
                          //       (context) => FeeBottomSheet(
                          //     amountDetail: feeDetail.amountDetail,
                          //   ),
                          // );
                        },
                        icon: Icon(CupertinoIcons.square_favorites),
                        label: Text('Start Exam'),
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${lang.dateFrom}: ', style: k16BoldStyle),
                          Text(exam?.examFrom ?? '', style: k14SimpleStyle),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Text('${lang.totalAttempts}: ',
                                style: k16BoldStyle),
                            Text(exam?.attempt ?? '', style: k14SimpleStyle),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text('${lang.duration}: ', style: k16BoldStyle),
                          Text(exam?.duration ?? '', style: k14SimpleStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${lang.dateTo}: ', style: k16BoldStyle),
                          Text(exam?.examTo ?? '', style: k14SimpleStyle),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Text('${lang.attempted}: ', style: k16BoldStyle),
                            Text(exam?.attempts, style: k14SimpleStyle),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text('${lang.status}: ', style: k16BoldStyle),
                          Text(status, style: k14SimpleStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
