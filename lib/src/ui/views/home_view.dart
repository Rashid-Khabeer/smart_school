import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/modules_model.dart';
import 'package:smart_school/src/data/models/sign-in_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/confirmation_dialog.dart';
import 'package:smart_school/src/ui/modals/language_dialog.dart';
import 'package:smart_school/src/ui/modals/loading_dialog.dart';
import 'package:smart_school/src/ui/pages/base_page.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/views/profile_view.dart';
import 'package:smart_school/src/ui/views/time-table_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/nav.dart';
import 'package:toast/toast.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _isLoading = true;

  Modules _modules = Modules();

  _getData() async {
    ServerError _error;
    _modules = await RestService()
        .getModule(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: ModuleRequest(),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, context);
    });
    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _fetchData() async => await _getData();

  bool _getStatus(String text) {
    var _value = false;
    _modules.data.forEach((element) {
      if (element.shortCode == text) {
        if (element.status == '1')
          _value = true;
        else
          _value = false;
      }
    });
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => _isLoading
          ? LoadingWidget()
          : RefreshIndicator(
              onRefresh: _fetchData,
              child: _modules?.data?.isEmpty ?? true
                  ? NoDataWidget()
                  : ListView(
                      children: [
                        _CardWidget(
                          icon: CupertinoIcons.person,
                          title: lang.profile,
                          onTap: () => AppNavigation.to(
                            context,
                            BasePage(
                              body: ProfileView(),
                              title: lang.profile,
                            ),
                          ),
                        ),
                        if (_getStatus('fees'))
                          _CardWidget(
                            icon: FontAwesome5.money_bill_alt,
                            title: lang.fee,
                            onTap: () =>
                                AppNavigation.toPage(context, AppPage.fee),
                          ),
                        if (_getStatus('live_classes'))
                          _CardWidget(
                            icon: CupertinoIcons.video_camera,
                            title: lang.live,
                            onTap: () => AppNavigation.toPage(
                                context, AppPage.liveClass),
                          ),
                        if (_getStatus('class_timetable'))
                          _CardWidget(
                            icon: CupertinoIcons.table,
                            title: lang.classTable,
                            onTap: () => AppNavigation.to(
                              context,
                              BasePage(
                                body: TimeTableView(),
                                title: lang.classTable,
                              ),
                            ),
                          ),
                        if (_getStatus('lesson_plan'))
                          _CardWidget(
                            icon: CupertinoIcons.calendar,
                            title: lang.lessonPlan,
                            onTap: () => AppNavigation.toPage(
                                context, AppPage.lessonPlan),
                          ),
                        if (_getStatus('syllabus_status'))
                          _CardWidget(
                            icon: CupertinoIcons.doc,
                            title: lang.syllabus,
                            onTap: () => AppNavigation.toPage(
                                context, AppPage.syllabusStatus),
                          ),
                        if (_getStatus('homework'))
                          _CardWidget(
                            icon: CupertinoIcons.lab_flask,
                            title: lang.homework,
                            onTap: () =>
                                AppNavigation.toPage(context, AppPage.homeWork),
                          ),
                        if (_getStatus('online_examination'))
                          _CardWidget(
                            icon: CupertinoIcons.wifi,
                            title: lang.exam,
                            onTap: () => AppNavigation.toPage(
                                context, AppPage.onlineExam),
                          ),
                        if (_getStatus('download_center'))
                          _CardWidget(
                            icon: FontAwesome.download,
                            title: lang.downloads,
                            onTap: () => AppNavigation.toPage(
                                context, AppPage.downloads),
                          ),
                        if (_getStatus('attendance'))
                          _CardWidget(
                            icon: FontAwesome5.clock,
                            title: lang.attendance,
                            onTap: () => AppNavigation.toPage(
                                context, AppPage.attendance),
                          ),
                        if (_getStatus('examinations'))
                          _CardWidget(
                            icon: CupertinoIcons.graph_circle,
                            title: lang.examination,
                            onTap: () => AppNavigation.toPage(
                                context, AppPage.examination),
                          ),
                        if (_getStatus('notice_board'))
                          _CardWidget(
                            icon: FontAwesome5.sticky_note,
                            title: lang.notice,
                            onTap: () =>
                                AppNavigation.toPage(context, AppPage.notice),
                          ),
                        if (_getStatus('teachers_rating'))
                          _CardWidget(
                            icon: CupertinoIcons.star,
                            title: lang.reviews,
                            onTap: () =>
                                AppNavigation.toPage(context, AppPage.teachers),
                          ),
                        if (_getStatus('library'))
                          _CardWidget(
                            icon: FontAwesome5.address_book,
                            title: lang.library,
                            onTap: () =>
                                AppNavigation.toPage(context, AppPage.library),
                          ),
                        if (_getStatus('transport_routes'))
                          _CardWidget(
                            icon: CupertinoIcons.bus,
                            title: lang.transport,
                            onTap: () => AppNavigation.toPage(
                                context, AppPage.transport),
                          ),
                        if (_getStatus('hostel_rooms'))
                          _CardWidget(
                            icon: CupertinoIcons.bed_double,
                            title: lang.hostel,
                            onTap: () =>
                                AppNavigation.toPage(context, AppPage.hostels),
                          ),
                        // _CardWidget(
                        //   icon: CupertinoIcons.chat_bubble_2,
                        //   title: lang.chat,
                        // ),
                        _CardWidget(
                          icon: CupertinoIcons.list_number,
                          title: lang.task,
                          onTap: () =>
                              AppNavigation.toPage(context, AppPage.tasks),
                        ),
                        _CardWidget(
                          icon: CupertinoIcons.globe,
                          title: lang.change,
                          onTap: () => openLanguageDialog(context: context),
                          // onTap: _signOut,
                        ),
                        _CardWidget(
                          icon: CupertinoIcons.square_arrow_left,
                          title: lang.logOut,
                          onTap: () async {
                            if ((await openConfirmationDialog(
                              title: lang.confirm,
                              content: lang.confirmLogout,
                              context: context,
                            ))) _signOut();
                          },
                        ),
                      ],
                    ),
            ),
    );
  }

  _signOut() async {
    openLoadingDialog(context: context);
    String deviceToken = await FirebaseMessaging().getToken();
    ServerError _error;
    SignOutResponse _response = await RestService()
        .signOut(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: SignOutRequest(deviceToken: deviceToken),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, context);
    });
    Navigator.of(context).pop();
    if (_response != null) {
      print(_response.status);
      AppData().clearData();
      AppData().clearIds();
      Navigator.of(context).pop();
      AppNavigation.toPage(context, AppPage.signIn);
    }
  }
}

class _CardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  final Color firstColor, secondColor;

  _CardWidget({
    this.title,
    this.icon,
    this.onTap,
    this.secondColor,
    this.firstColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              firstColor ?? Colors.lightBlue,
              secondColor ?? Colors.lightGreen,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24),
              ),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
