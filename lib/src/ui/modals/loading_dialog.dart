import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:smart_school/src/utility/constants.dart';

openLoadingDialog({
  @required BuildContext context,
  String text = 'Please Wait',
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      insetPadding: EdgeInsets.all(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 35,
            height: 35,
            child: LoadingIndicator(
              indicatorType: Indicator.ballTrianglePath,
              color: kMainColor,
            ),
          ),
          SizedBox(height: 15),
          Text(text + "...")
        ],
      ),
    ),
  );
}
