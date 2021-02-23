import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/student-syllabus_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class SyllabusStatusDetailPage extends StatefulWidget {
  final SyllabusStatus syllabusStatus;

  SyllabusStatusDetailPage({this.syllabusStatus});

  @override
  _SyllabusStatusDetailPageState createState() =>
      _SyllabusStatusDetailPageState();
}

class _SyllabusStatusDetailPageState extends State<SyllabusStatusDetailPage> {
  bool _isLoading = true;
  List<SyllabusDetail> _syllabus = [];

  _getData() async {
    ServerError _error;
    print(AppData().getUserId());
    _syllabus = await RestService()
        .getSyllabusDetail(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: SyllabusDetailRequest(
        subjectGroupSubjectId: widget.syllabusStatus.subjectGroupSubjectId,
        subjectGroupClassSectionId: widget.syllabusStatus.id,
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
          title: Text(lang.syllabusDetail),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _syllabus?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _syllabus?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          detail: _syllabus[index],
                          count: ++index,
                          lang: lang,
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final SyllabusDetail detail;
  final int count;
  final AppLocalizations lang;

  _RowItem({this.detail, this.count, this.lang});

  @override
  Widget build(BuildContext context) {
    final _totalComplete = double.parse(detail.totalComplete);
    final _total = double.parse(detail.total);
    var _complete;
    var _completePercentage;
    String _status;
    if (_total != 0) {
      _complete = (_totalComplete / _total);
      _completePercentage = (_complete * 100.0);
      _status = "${_completePercentage.round()}% ${lang.completed}";
    } else {
      _complete = 0.0;
      _completePercentage = 0.0;
      _status = lang.noStatus;
    }
    return Card(
      child: Column(
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
                Text(
                  count.toString(),
                  style: k16BoldStyle,
                ),
                SizedBox(width: 50.0),
                Text(
                  detail.name,
                  style: k16BoldStyle,
                ),
                Spacer(),
                Text(
                  _status,
                  style: k16BoldStyle,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          ListView.builder(
            itemCount: detail.topics?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Topics topic = detail.topics[index];
              String status;
              if (topic.status == '1')
                status = '${lang.complete} (${topic.completeDate})';
              else
                status = lang.incomplete;
              return Padding(
                padding: EdgeInsets.fromLTRB(20.0, 3.0, 10.0, 3.0),
                child: Row(
                  children: [
                    Text(
                      "$count.${++index}",
                      style: k14Style,
                    ),
                    SizedBox(width: 30.0),
                    Text(
                      '${topic.name}',
                      style: k14Style,
                    ),
                    Spacer(),
                    Text(
                      status,
                      style: k14Style,
                    )
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
