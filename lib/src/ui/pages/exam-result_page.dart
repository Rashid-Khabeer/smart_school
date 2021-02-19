import 'package:flutter/material.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';

class ExamResultPage extends StatefulWidget {
  final String id;

  ExamResultPage({this.id});

  @override
  _ExamResultPageState createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => Scaffold(
        appBar: AppBar(
          title: Text(lang.examResult),
        ),
      ),
    );
  }
}
