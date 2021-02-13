import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/live-class_model.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveClassPage extends StatefulWidget {
  @override
  _LiveClassPageState createState() => _LiveClassPageState();
}

class _LiveClassPageState extends State<LiveClassPage> {
  bool _isLoading = true;
  LiveClass _liveClass = LiveClass();

  _getData() async {
    ServerError _error;
    print(AppData().readLastUser().studentRecord.studentId);
    _liveClass = await RestService()
        .getLiveClass(
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
    _isLoading = false;
    setState(() {});
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
          title: Text(lang.liveClass),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _liveClass?.liveClassData?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _liveClass?.liveClassData?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          data: _liveClass.liveClassData[index],
                        ),
                      ),
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _RowItem extends StatelessWidget {
  final LiveClassData data;

  _RowItem({this.data});

  BuildContext _context;
  AppLocalizations lang;

  @override
  Widget build(BuildContext context) {
    _context = context;
    lang = AppLocalizations.of(context);
    Color _color;
    String _text;
    bool _isMeeting = false;
    if (data.status == '0') {
      _color = Colors.orange;
      _text = lang.awaited;
      _isMeeting = true;
    } else if (data.status == '2') {
      _color = Colors.green;
      _text = lang.finished;
    } else {
      _color = Colors.red;
      _text = lang.cancelled;
    }
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 5.0,
              top: _isMeeting ? 0 : 10.0,
              bottom: _isMeeting ? 0 : 10.0,
            ),
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Text(data?.title ?? 'Title', style: k16BoldStyle),
                Spacer(),
                _isMeeting
                    ? TextButton.icon(
                        onPressed: () => _join(data.id, data.joinUrl),
                        icon: Icon(CupertinoIcons.square_favorites),
                        label: Text(lang.join),
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${lang.date}\t\t\t\t\t\t\t\t\t\t\t\t\t\t${data?.date ?? '05-23-23'} ",
                      style: k14Style,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      lang.className("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t" +
                              data?.className ??
                          'Class 1' "(${data?.section ?? 'A'})"),
                      style: k14Style,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                  color: _color,
                  child: Text(
                    _text,
                    style: k14Style.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _join(String meetingId, String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      Toast.show('Could not launch $url', _context);
    ServerError _error;
    print(AppData().readLastUser().studentRecord.studentId);
    LiveClassHistory _history = await RestService()
        .getLiveClassHistory(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: LiveClassRequest(
        id: AppData().readLastUser().studentRecord.studentId,
        conferenceId: meetingId,
      ),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, _context);
    });
    if (_history != null) Toast.show(_history.message, _context);
  }
}
