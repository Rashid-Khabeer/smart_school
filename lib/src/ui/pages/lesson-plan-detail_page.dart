import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/lesson-plan_model.dart';
import 'package:smart_school/src/services/download_service.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/home-work-bottom_sheet.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonPlanDetailPage extends StatefulWidget {
  final LessonDays lessonDays;

  LessonPlanDetailPage({this.lessonDays});

  @override
  _LessonPlanDetailState createState() => _LessonPlanDetailState();
}

class _LessonPlanDetailState extends State<LessonPlanDetailPage> {
  bool _isLoading = true;
  LessonPlanDetails _details;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _getData() async {
    ServerError _error;
    _details = await RestService()
        .getLessonPlanDetails(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: LessonPlanDetailsRequest(
        subjectSyllabusId: widget.lessonDays.subjectSyllabusId,
      ),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, context);
      _isLoading = true;
    });
    if (_details.data == null)
      _isLoading = true;
    else
      _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final _time = widget.lessonDays.timeFrom.isNotEmpty
        ? '${widget.lessonDays.timeFrom}-${widget.lessonDays.timeTo}'
        : '';

    return LocalizedView(
      builder: (ctx, lang) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(lang.lessonPlan),
        ),
        body: _isLoading
            ? Center(
                child: LoadingWidget(),
              )
            : SingleChildScrollView(
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey.shade300,
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                print(_details.data.presentation);
                                _scaffoldKey.currentState.showBottomSheet(
                                  (context) => HomeWorkBottomSheet(
                                    detail: _details.data.presentation,
                                  ),
                                );
                                // Scaffold.of(context).showBottomSheet(
                                //       (context) => FeeBottomSheet(
                                //     amountDetail: feeDetail.amountDetail,
                                //   ),
                                // );
                              },
                              icon: Icon(CupertinoIcons.square_favorites),
                              label: Text(lang.presentation),
                            ),
                            Spacer(),
                            if (_details.data.lectureVideo.isNotEmpty)
                              IconButton(
                                onPressed: () async {
                                  await DownloadService.download(
                                      '/uploads/syllabus_attachment/' +
                                          _details.data.lectureVideo);
                                },
                                icon: Icon(FontAwesome.file_video_o),
                              ),
                            if (_details.data.attachment.isNotEmpty)
                              IconButton(
                                onPressed: _download,
                                icon: Icon(FontAwesome5.file_pdf),
                              ),
                            if (_details.data.youtube.isNotEmpty)
                              IconButton(
                                onPressed: () async {
                                  print(_details.data.youtube);
                                  if (await canLaunch(_details.data.youtube))
                                    await launch(_details.data.youtube);
                                  else
                                    Toast.show('Could not launch', context);
                                },
                                icon: Icon(FontAwesome.youtube),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${lang.className('${widget.lessonDays.className} (${widget.lessonDays.section})')}",
                              style: k14Style,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "${lang.subject}: ${widget.lessonDays.name} ${widget.lessonDays.code.isNotEmpty ? '(${widget.lessonDays.code})' : ''}",
                                style: k14Style,
                              ),
                            ),
                            Text(
                              "${lang.date}: ${widget.lessonDays.date} $_time",
                              style: k14Style,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "${lang.lesson}: ${_details.data.lessonName}",
                                style: k14Style,
                              ),
                            ),
                            Text(
                              "${lang.topic}: ${_details.data.topicName}",
                              style: k14Style,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "${lang.subTopic}: ${_details.data.subTopic}",
                                style: k14Style,
                              ),
                            ),
                            Text(
                              "${lang.generalObjectives}: ${_details.data.generalObjectives}",
                              style: k14Style,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "${lang.teachingMethod}: ${_details.data.teachingMethod}",
                                style: k14Style,
                              ),
                            ),
                            Text(
                              "${lang.previousKnowledge}: ${_details.data.previousKnowledge}",
                              style: k14Style,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "${lang.comprehensiveKnowledge}: ${_details.data.comprehensiveQuestions}",
                                style: k14Style,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _download() async => await DownloadService.download(
      '/uploads/syllabus_attachment/' + _details.data.attachment);
}
