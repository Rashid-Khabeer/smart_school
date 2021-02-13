import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/sign-in_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/language_dialog.dart';
import 'package:smart_school/src/ui/modals/loading_dialog.dart';
import 'package:smart_school/src/ui/pages/base_page.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/views/profile_view.dart';
import 'package:smart_school/src/ui/views/time-table_view.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/nav.dart';
import 'package:toast/toast.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
          child: Column(
            children: [
              Row(
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
                  _CardWidget(
                    icon: FontAwesome5.money_bill_alt,
                    title: lang.fee,
                    onTap: () => AppNavigation.toPage(context, AppPage.fee),
                  ),
                  _CardWidget(
                    icon: CupertinoIcons.video_camera,
                    title: lang.live,
                    onTap: () =>
                        AppNavigation.toPage(context, AppPage.liveClass),
                  ),
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
                ],
              ),
              Row(
                children: [
                  _CardWidget(
                    icon: CupertinoIcons.calendar,
                    title: lang.lessonPlan,
                    onTap: () =>
                        AppNavigation.toPage(context, AppPage.lessonPlan),
                  ),
                  _CardWidget(
                    icon: CupertinoIcons.doc,
                    title: lang.syllabus,
                    onTap: () =>
                        AppNavigation.toPage(context, AppPage.syllabusStatus),
                  ),
                  _CardWidget(
                    icon: CupertinoIcons.lab_flask,
                    title: lang.homework,
                    onTap: () =>
                        AppNavigation.toPage(context, AppPage.homeWork),
                  ),
                  _CardWidget(
                    icon: CupertinoIcons.wifi,
                    title: lang.exam,
                    onTap: () =>
                        AppNavigation.toPage(context, AppPage.onlineExam),
                  ),
                ],
              ),
              Row(
                children: [
                  _CardWidget(
                    icon: FontAwesome.download,
                    title: lang.downloads,
                    onTap: () =>
                        AppNavigation.toPage(context, AppPage.downloads),
                  ),
                  _CardWidget(
                    icon: FontAwesome5.clock,
                    title: lang.attendance,
                    // onTap: () =>
                    //     AppNavigation.toPage(context, AppPage.attendance),
                  ),
                  _CardWidget(
                    icon: CupertinoIcons.graph_circle,
                    title: lang.examination,
                  ),
                  _CardWidget(
                    icon: FontAwesome5.sticky_note,
                    title: lang.notice,
                    onTap: () => AppNavigation.toPage(context, AppPage.notice),
                  ),
                ],
              ),
              Row(
                children: [
                  _CardWidget(
                    icon: CupertinoIcons.star,
                    title: lang.reviews,
                  ),
                  _CardWidget(
                    icon: FontAwesome5.address_book,
                    title: lang.library,
                  ),
                  _CardWidget(
                    icon: CupertinoIcons.bus,
                    title: lang.transport,
                    // onTap: () =>
                    //     AppNavigation.toPage(context, AppPage.transport),
                  ),
                  _CardWidget(
                    icon: CupertinoIcons.bed_double,
                    title: lang.hostel,
                  ),
                ],
              ),
              Row(
                children: [
                  // Spacer(),
                  _CardWidget(
                    icon: CupertinoIcons.chat_bubble_2,
                    title: lang.chat,
                  ),
                  _CardWidget(
                    icon: CupertinoIcons.list_number,
                    title: lang.task,
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
                    onTap: _signOut,
                  ),
                  // Spacer(),
                ],
              ),
            ],
          ),
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

  _CardWidget({this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: kMainColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Icon(icon, size: 30, color: Colors.white),
              ),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
