import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/tasks_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/button_widget.dart';
import 'package:smart_school/src/ui/widgets/date-picker_field.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

Future openAddTaskDialog({
  @required BuildContext context,
}) async {
  DateTime dateTime = DateTime.now();
  String date = DateFormat('yyyy-M-dd').format(dateTime);
  String title;
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LocalizedView(
      builder: (context, lang) => AlertDialog(
        insetPadding: EdgeInsets.all(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(lang.addTask, style: k16BoldStyle),
        actions: [
          AppButtonWidget(
            text: lang.add,
            onPressed: () async {
              if ((title?.isEmpty ?? true)) {
                Toast.show(lang.emptyDate, context);
                return;
              }
              if (date?.isEmpty ?? true) {
                Toast.show(lang.emptyTitle, context);
                return;
              }
              Toast.show('Adding....', context);
              final _response = await RestService()
                  .addTask(
                authKey: AppData().readLastUser().token,
                userId: AppData().readLastUser().userId,
                request: AddTask(
                  userId: AppData().readLastUser().userId,
                  date: date,
                  title: title,
                ),
              )
                  .catchError((error) {
                print(error);
                Toast.show(ServerError.withError(error).errorMessage, context);
              });
              if (_response != null) {
                Toast.show(_response.msg, context);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              onChanged: (value) => title = value,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: lang.taskTitle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            DatePickerFormField(
              onChanged: (value) => dateTime = value,
              label: lang.taskDate,
            ),
          ],
        ),
      ),
    ),
  );
}
