import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/examination_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class ExamResultPage extends StatefulWidget {
  final String id;

  ExamResultPage({this.id});

  @override
  _ExamResultPageState createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  bool _isLoading = true;
  ExamResult _result = ExamResult();

  _getData() async {
    ServerError _error;
    _result = await RestService()
        .getExamResult(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: ExamResultRequest(
        id: AppData().readLastUser().studentRecord.studentId,
        examId: widget.id,
      ),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
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
          title: Text(lang.examResult),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _result?.exam?.subjectResult?.isEmpty ?? true
                    ? NoDataWidget()
                    : Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _result?.exam?.exam ?? '',
                                  style: k16BoldStyle,
                                ),
                                if ((_result?.exam?.isConsolidate ?? 0) != 0)
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    color: Colors.orange,
                                    child: Text(
                                      lang.consolidate,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(lang.subject, style: k14Style),
                                  ),
                                  DataColumn(
                                    label: Text(lang.passingMarks,
                                        style: k14Style),
                                  ),
                                  DataColumn(
                                    label: Text(lang.obtainedMarks,
                                        style: k14Style),
                                  ),
                                  DataColumn(
                                    label: Text(lang.result, style: k14Style),
                                  ),
                                  DataColumn(
                                      label:
                                          Text(lang.note, style: k16BoldStyle)),
                                ],
                                rows:
                                    _result?.exam?.subjectResult?.isNotEmpty ??
                                            false
                                        ? _getDataRow()
                                        : [],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${lang.grandTotal}\t\t\t${_result?.exam?.getMarks ?? ''}/${_result?.exam?.totalMarks ?? ''}',
                                        style: k14Style,
                                      ),
                                      Text(
                                        '${lang.percentage}\t\t\t${_result?.exam?.percentage ?? ''}',
                                        style: k14Style,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${lang.division} ${_result?.exam?.division ?? ''}',
                                        style: k14Style,
                                      ),
                                      Spacer(),
                                      Text(
                                        lang.result,
                                        style: k14Style,
                                      ),
                                      SizedBox(width: 5.0),
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        color: (_result?.exam?.resultStatus ??
                                                    '') ==
                                                'pass'
                                            ? Colors.green
                                            : Colors.red,
                                        child: Text(
                                          '${_result?.exam?.resultStatus ?? ''}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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

  _getDataRow() {
    return _result.exam.subjectResult.map((e) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              e.name,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              e.minMarks,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              '${e.attendance == 'absent' ? 'Absent' : '${e.getMarks}'}/${e.maxMarks}',
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              '${double.parse(e.getMarks) > double.parse(e.minMarks) ? 'pass' : 'fail'}',
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              e.note,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
        ],
      );
    }).toList();
  }
}
