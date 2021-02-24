import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/ui/views/home_view.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/views/profile_view.dart';
import 'package:smart_school/src/ui/views/time-table_view.dart';
import 'package:smart_school/src/utility/assets.dart';
import 'package:smart_school/src/utility/constants.dart';
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
                    '${lang.className(AppData().readLastUser().studentRecord.className + '(${AppData().readLastUser().studentRecord.section})')}',
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
        bottomNavigationBar: BottomNavyBar(
          showElevation: true,
          selectedIndex: _index,
          onItemSelected: (index) => setState(() => _index = index),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text(lang.menu),
              activeColor: kMainColor,
              inactiveColor: Colors.grey,
            ),
            BottomNavyBarItem(
              icon: Icon(CupertinoIcons.table),
              title: Text(lang.classTable),
              activeColor: kMainColor,
              inactiveColor: Colors.grey,
            ),
            // BottomNavyBarItem(
            //   icon: Icon(FontAwesome.whatsapp),
            //   title: Text(lang.chat),
            //   activeColor: Colors.blue,
            //   inactiveColor: kMainColor,
            // ),
            BottomNavyBarItem(
              icon: Icon(CupertinoIcons.person),
              title: Text(lang.profile),
              activeColor: kMainColor,
              inactiveColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
