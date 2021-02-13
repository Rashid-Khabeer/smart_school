import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/utility/constants.dart';

class AppButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;

  AppButtonWidget({
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: kMainColor,
      ),
    );
  }
}
