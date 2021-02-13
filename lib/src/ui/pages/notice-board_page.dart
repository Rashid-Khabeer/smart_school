import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/notice-board_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/home-work-bottom_sheet.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class NoticeBoardPage extends StatefulWidget {
  @override
  _NoticeBoardPageState createState() => _NoticeBoardPageState();
}

class _NoticeBoardPageState extends State<NoticeBoardPage> {
  bool _isLoading = true;
  NoticeBoard _noticeBoard = NoticeBoard();

  _getData() async {
    ServerError _error;
    _noticeBoard = await RestService()
        .getNoticeBoard(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: NoticeBoardRequest(
        type: AppData().readLastUser().studentRecord.role,
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
          title: Text(lang.notice),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _noticeBoard?.data?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _noticeBoard?.data?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          data: _noticeBoard.data[index],
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final NoticeBoardData data;

  _RowItem({this.data});

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
              color: Colors.grey.shade300,
              child: Text(data.title, style: k16BoldStyle),
            ),
            Row(
              children: [
                SizedBox(width: 10.0),
                Text('${lang.date}\t\t\t${data.date}', style: k16BoldStyle),
                Spacer(),
                TextButton.icon(
                  onPressed: () {
                    Scaffold.of(context).showBottomSheet(
                      (context) => HomeWorkBottomSheet(
                        detail: data.message,
                      ),
                    );
                  },
                  icon: Icon(CupertinoIcons.square_favorites),
                  label: Text(lang.view),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
