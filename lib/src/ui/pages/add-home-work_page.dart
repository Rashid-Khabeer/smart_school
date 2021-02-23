import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/loading_dialog.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/button_widget.dart';
import 'package:smart_school/src/ui/widgets/images-selector_widget.dart';
import 'package:smart_school/src/ui/widgets/text-field_widget.dart';
import 'package:smart_school/src/utility/validators.dart';
import 'package:toast/toast.dart';

class AddHomeWorkPage extends StatefulWidget {
  final String workId;

  AddHomeWorkPage({this.workId});

  @override
  _AddHomeWorkPageState createState() => _AddHomeWorkPageState();
}

class _AddHomeWorkPageState extends State<AddHomeWorkPage> {
  File _image;
  String _message;
  final _formKey = GlobalKey<FormState>();
  var _mode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => Scaffold(
        appBar: AppBar(
          title: Text(lang.addHomeWork),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _mode,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    onSaved: (value) => _message = value,
                    labelText: lang.message,
                    validator: Validators.required,
                    maxLines: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: ImageSelector(
                      image: _image,
                      onChanged: (value) => _image = value,
                    ),
                  ),
                  AppButtonWidget(
                    text: lang.upload,
                    onPressed: _upload,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _upload() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_image == null) {
        Toast.show('Please select image', context);
        return;
      }
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      openLoadingDialog(context: context);
      ServerError _error;
      final _response = await RestService()
          .addHomeWork(
        authKey: AppData().readLastUser().token,
        userId: AppData().readLastUser().userId,
        file: _image,
        message: _message,
        student_id: AppData().getUserId(),
        homework_id: widget.workId,
      )
          .catchError((e) {
        _error = ServerError.withError(e);
        print(e);
        Toast.show(_error.errorMessage, context);
      });
      Navigator.of(context).pop();
      if (_error == null) {
        print(_response);
        Toast.show(_response.toString(), context);
        Navigator.of(context).pop();
      }
    } else
      setState(() => _mode = AutovalidateMode.onUserInteraction);
  }
}
