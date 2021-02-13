import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/mixins/locale_mixin.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/nav.dart';

class SchoolApp extends ValueListenableBuilder {
  SchoolApp()
      : super(
          valueListenable: LocaleData.locale,
          builder: (context, value, _) {
            return MaterialApp(
              title: 'Smart School',
              theme: ThemeData(
                cupertinoOverrideTheme: CupertinoThemeData(
                  primaryColor: kMainColor,
                ),
                cursorColor: kMainColor,
                accentColor: kMainColor,
                primaryColor: kMainColor,
                fontFamily: 'GoogleSans',
              ),
              locale: value,
              routes: AppNavigation.routes,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );

  static Future initiate() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FlutterDownloader.initialize(debug: true);
    await AppData.initiate();
    // AppData().clearData();
  }
}
