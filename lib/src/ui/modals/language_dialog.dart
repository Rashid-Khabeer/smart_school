import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/utility/constants.dart';

openLanguageDialog({
  @required BuildContext context,
  String text = 'Please Wait',
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LocalizedView(
      builder: (context, lang) => AlertDialog(
        insetPadding: EdgeInsets.all(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(lang.language, style: k16BoldStyle),
            ),
            TextButton(
              onPressed: () {
                AppData().changeLocale(Locale('en'));
                AppData().setLocale('en');
                Navigator.of(context).pop();
              },
              child: Text(lang.english, style: k16BoldStyle),
            ),
            TextButton(
              onPressed: () {
                AppData().changeLocale(Locale('ar'));
                AppData().setLocale('ar');
                Navigator.of(context).pop();
              },
              child: Text(lang.arabic, style: k16BoldStyle),
            ),
            TextButton(
              onPressed: () {
                AppData().changeLocale(Locale('ur'));
                AppData().setLocale('ur');
                Navigator.of(context).pop();
              },
              child: Text(lang.kurdish, style: k16BoldStyle),
            ),
          ],
        ),
      ),
    ),
  );
}
