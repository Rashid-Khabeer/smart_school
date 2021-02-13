import 'package:flutter/material.dart';
import 'package:smart_school/src/app.dart';

void main() async {
  await SchoolApp.initiate();
  runApp(SchoolApp());
}
