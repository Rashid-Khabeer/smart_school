import 'package:flutter/cupertino.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/ui/pages/attendance_page.dart';
import 'package:smart_school/src/ui/pages/downloads_page.dart';
import 'package:smart_school/src/ui/pages/examination_page.dart';
import 'package:smart_school/src/ui/pages/fees_page.dart';
import 'package:smart_school/src/ui/pages/home-work_page.dart';
import 'package:smart_school/src/ui/pages/home_page.dart';
import 'package:smart_school/src/ui/pages/hostel_page.dart';
import 'package:smart_school/src/ui/pages/lesson-plan_page.dart';
import 'package:smart_school/src/ui/pages/library_page.dart';
import 'package:smart_school/src/ui/pages/live-classes_page.dart';
import 'package:smart_school/src/ui/pages/notice-board_page.dart';
import 'package:smart_school/src/ui/pages/online-exam_page.dart';
import 'package:smart_school/src/ui/pages/sign-in_page.dart';
import 'package:smart_school/src/ui/pages/syllabus-status_page.dart';
import 'package:smart_school/src/ui/pages/task_page.dart';
import 'package:smart_school/src/ui/pages/teachers_page.dart';
import 'package:smart_school/src/ui/pages/transport_page.dart';

class AppPage {
  final String _name;

  const AppPage._(this._name);

  static const mainPage = AppPage._('/');

  // static const mainPage = AppPage._('/sdf');
  static const signIn = AppPage._('/signIn');
  static const home = AppPage._('/home');
  static const notice = AppPage._('/notice');
  static const transport = AppPage._('/transport');
  static const fee = AppPage._('/fee');
  static const lessonPlan = AppPage._('/lessonPlan');
  static const syllabusStatus = AppPage._('/syllabusStatus');
  static const homeWork = AppPage._('/homeWork');
  static const attendance = AppPage._('/attendance');
  static const liveClass = AppPage._('/liveClass');
  static const onlineExam = AppPage._('/onlineExam');
  static const downloads = AppPage._('/downloads');
  static const examination = AppPage._('/examination');
  static const teachers = AppPage._('/teachers');
  static const hostels = AppPage._('/hostels');
  static const library = AppPage._('/library');
  static const tasks = AppPage._('/tasks');
}

abstract class AppNavigation {
  static Future<void> to(BuildContext context, Widget page) async {
    return await Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => page,
    ));
  }

  static Future<void> toPage(BuildContext context, AppPage page) async {
    return await Navigator.of(context).pushNamed(page._name);
  }

  static void backToHome(BuildContext context) => Navigator.of(context)
      .popUntil((route) => route.settings.name == AppPage.home._name);

  static final routes = <String, WidgetBuilder>{
    AppPage.mainPage._name: (context) =>
        AppData().isUserSaved() ? HomePage() : SignInPage(),
    AppPage.signIn._name: (context) => SignInPage(),
    AppPage.home._name: (context) => HomePage(),
    AppPage.notice._name: (context) => NoticeBoardPage(),
    AppPage.transport._name: (context) => TransportPage(),
    AppPage.fee._name: (context) => FeesPage(),
    AppPage.lessonPlan._name: (context) => LessonPlanPage(),
    AppPage.syllabusStatus._name: (context) => SyllabusStatusPage(),
    AppPage.homeWork._name: (context) => HomeWorkPage(),
    AppPage.attendance._name: (context) => AttendancePage(),
    AppPage.liveClass._name: (context) => LiveClassPage(),
    AppPage.onlineExam._name: (context) => OnlineExamPage(),
    AppPage.downloads._name: (context) => DownloadsPage(),
    AppPage.examination._name: (context) => ExaminationPage(),
    AppPage.teachers._name: (context) => TeachersPage(),
    AppPage.hostels._name: (context) => HostelPage(),
    AppPage.library._name: (context) => LibraryPage(),
    AppPage.tasks._name: (context) => TaskPage(),
  };
}
