import 'dart:io';

import 'package:flutter/material.dart';
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
  List<File> _images = [];
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
                      images: _images,
                      onChanged: (value) => _images = value,
                    ),
                  ),
                  AppButtonWidget(
                    text: 'Upload',
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

  _upload() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_images.isEmpty) {
        Toast.show('Please select image', context);
        return;
      }
      print(_message);
    } else
      setState(() => _mode = AutovalidateMode.onUserInteraction);
  }
}
