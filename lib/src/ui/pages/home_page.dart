import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/ui/views/home_view.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/views/profile_view.dart';
import 'package:smart_school/src/ui/views/time-table_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  static List<Widget> _items = [
    HomeView(),
    TimeTableView(),
    Text(''),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    print(AppData().readLastUser().userId);
    print(AppData().readLastUser().token);
    print(AppData().readLastUser().studentRecord.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) => Scaffold(
        appBar: AppBar(
          title: Text(lang.appName),
          centerTitle: true,
          leading: Center(
            child: Text('Logo'),
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
              onPressed: () {},
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
