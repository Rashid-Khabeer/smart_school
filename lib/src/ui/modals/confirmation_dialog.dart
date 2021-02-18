import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/button_widget.dart';
import 'package:smart_school/src/utility/constants.dart';

Future openConfirmationDialog({
  @required String title,
  @required String content,
  @required BuildContext context,
}) async {
  return await showDialog(
        context: context,
        builder: (ctx) => LocalizedView(
          builder: (context1, lang) => AlertDialog(
            insetPadding: EdgeInsets.all(50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(title, style: k16BoldStyle),
            content: Text(content, style: k14SimpleStyle),
            actions: [
              AppButtonWidget(
                text: 'Yes',
                onPressed: () => Navigator.of(context).pop(true),
              ),
              AppButtonWidget(
                text: 'No',
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
        ),
      ) ??
      false;
}
