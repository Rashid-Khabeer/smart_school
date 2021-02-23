import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/download_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/download_service.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class DownloadsPage extends StatefulWidget {
  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage>
    with SingleTickerProviderStateMixin {
  List<String> _list = [];
  final _keysList = [
    'Assignments',
    'Study Material',
    'Syllabus',
    'Other Download'
  ];
  TabController _tabController;
  AppLocalizations lang;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _keysList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    lang = AppLocalizations.of(context);
    _list.clear();
    _list.addAll([
      lang.assignments,
      lang.studyMaterial,
      lang.syllabus,
      lang.otherDownloads
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.downloads),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: kMainColor,
          controller: _tabController,
          tabs: _list.map((e) {
            return Tab(
              child: Text(e, style: k14Style),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        children: [
          PageBody(tag: _keysList[0]),
          PageBody(tag: _keysList[1]),
          PageBody(tag: _keysList[2]),
          PageBody(tag: _keysList[3]),
        ],
        controller: _tabController,
      ),
    );
  }
}

class PageBody extends StatefulWidget {
  final String tag;

  PageBody({this.tag});

  @override
  _PageBodyState createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  bool _isLoading = true;
  Downloads _downloads = Downloads();

  _getData() async {
    ServerError _error;
    _downloads = await RestService()
        .getDownloads(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: DownloadRequest(widget.tag),
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
    return _isLoading
        ? LoadingWidget()
        : RefreshIndicator(
            onRefresh: _fetchData,
            child: _downloads?.downloads?.isEmpty ?? true
                ? NoDataWidget()
                : ListView.builder(
                    itemCount: _downloads?.downloads?.length ?? 0,
                    itemBuilder: (context, index) => _RowItem(
                      data: _downloads.downloads[index],
                    ),
                  ),
          );
  }
}

class _RowItem extends StatelessWidget {
  final DownloadData data;

  _RowItem({this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                  data.title,
                  style: k16BoldStyle,
                ),
                Spacer(),
                Text(
                  data.date,
                  style: k16BoldStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(data.note, style: k14SimpleStyle),
                Spacer(),
                IconButton(
                  icon: Icon(FontAwesome.download),
                  onPressed: () async =>
                      DownloadService.download('uploads/' + data.file),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
