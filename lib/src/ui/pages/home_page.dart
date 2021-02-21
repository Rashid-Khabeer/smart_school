import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/ui/views/home_view.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/views/profile_view.dart';
import 'package:smart_school/src/ui/views/time-table_view.dart';
import 'package:smart_school/src/utility/assets.dart';
import 'package:smart_school/src/utility/nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _index = 0;
  static List<Widget> _items = [
    HomeView(),
    TimeTableView(),
    Text(''),
    ProfileView(),
  ];

  _firebaseListener() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  _iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) _iOSPermission();
    _firebaseListener();
    print(AppData().readLastUser().userId);
    print(AppData().readLastUser().token);
    print(AppData().readLastUser().studentRecord.studentId);
    print(AppData().getClassId());
    print(AppData().getSectionId());
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) => Scaffold(
        appBar: AppBar(
          title: Text(lang.appName),
          centerTitle: true,
          leading: Center(
            child: Image.asset(
              AppAssets.schoolLogo,
              fit: BoxFit.fill,
            ),
          ),
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      lang.stdName(
                          AppData().readLastUser().studentRecord.userName),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    '${lang.className(AppData().readLastUser().studentRecord.className)}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            preferredSize: Size(double.infinity, 30),
          ),
          elevation: 0,
          actions: [
            TextButton(
              child: Icon(CupertinoIcons.bell_fill, color: Colors.white),
              onPressed: () =>
                  AppNavigation.toPage(context, AppPage.notifications),
            ),
          ],
        ),
        body: _items[_index],
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: CircularNotchedRectangle(),
          child: CupertinoTabBar(
            currentIndex: _index,
            onTap: (index) => setState(() => _index = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_bullet),
                label: lang.menu,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.table),
                label: lang.classTable,
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesome.whatsapp),
                label: lang.chat,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: lang.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
