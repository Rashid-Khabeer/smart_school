import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/utility/assets.dart';
import 'package:smart_school/src/utility/constants.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 45,
        height: 45,
        child: LoadingIndicator(
          indicatorType: Indicator.ballTrianglePath,
          color: kMainColor,
        ),
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.noData,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 10.0),
            Text(lang.noData, style: k16BoldStyle.copyWith(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
