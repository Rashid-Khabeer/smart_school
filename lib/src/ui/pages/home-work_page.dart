import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/home-work_model.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/services/download_service.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/home-work-bottom_sheet.dart';
import 'package:smart_school/src/ui/pages/add-home-work_page.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/nav.dart';
import 'package:toast/toast.dart';

class HomeWorkPage extends StatefulWidget {
  @override
  _HomeWorkPageState createState() => _HomeWorkPageState();
}

class _HomeWorkPageState extends State<HomeWorkPage> {
  HomeWork _homeWork = HomeWork();
  bool _isLoading = true;

  _getData() async {
    ServerError _error;
    _homeWork = await RestService()
        .getHomeWork(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request:
          StudentRequest(id: AppData().getUserId()),
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
          title: Text(lang.homeWork),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _homeWork?.homeWorks?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _homeWork?.homeWorks?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          homeWorkDetail: _homeWork.homeWorks[index],
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final HomeWorkDetail homeWorkDetail;

  _RowItem({this.homeWorkDetail});

  @override
  Widget build(BuildContext context) {
    bool _isComplete;
    bool _hasData = false;
    int _status = int.parse(homeWorkDetail.homeWorkEvaluationId);
    if (_status > 0) {
      _isComplete = true;
      _hasData = true;
    } else if (_status == 0 || homeWorkDetail.homeWorkEvaluationId == '0') {
      _isComplete = false;
      _hasData = true;
    }
    return LocalizedView(
      builder: (ctx, lang) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 5.0,
              ),
              color: Colors.grey.shade300,
              child: Row(
                children: [
                  Text(homeWorkDetail.name, style: k16BoldStyle),
                  Spacer(),
                  homeWorkDetail.document.isEmpty
                      ? Container()
                      : IconButton(
                          icon: Icon(Icons.download_sharp),
                          onPressed: _download,
                        ),
                  IconButton(
                    icon: Icon(Icons.upload_sharp),
                    onPressed: () => AppNavigation.to(
                      context,
                      AddHomeWorkPage(
                        workId: homeWorkDetail.id,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Scaffold.of(context).showBottomSheet(
                        (context) => HomeWorkBottomSheet(
                          detail: homeWorkDetail.description,
                        ),
                      );
                    },
                    icon: Icon(CupertinoIcons.list_number),
                    label: Text(lang.view),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${homeWorkDetail.className} ${homeWorkDetail.section}',
                      style: k14Style),
                  _hasData
                      ? Container(
                          margin: EdgeInsets.only(left: 65.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 5.0),
                          color: _isComplete ? Colors.green : Colors.red,
                          child: Text(
                            _isComplete ? lang.complete : lang.incomplete,
                            style: k14Style.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                '${lang.homeWorkDate}\t\t\t\t\t\t${homeWorkDetail.homeWorkDate}\t\t\t\t ${lang.createdBy} ${homeWorkDetail.staffCreated}',
                style: k14Style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                '${lang.submissionDate}\t\t\t\t${homeWorkDetail.submitDate}\t\t\t\t ${lang.evaluatedBy} ${homeWorkDetail.staffEvaluated}',
                style: k14Style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                '${lang.homeWorkDate}\t\t\t\t\t\t${homeWorkDetail.homeWorkDate}',
                style: k14Style,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _download() async => await DownloadService.download(
      '/uploads/homework/' + homeWorkDetail.document);
}
