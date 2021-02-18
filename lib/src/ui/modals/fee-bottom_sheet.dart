import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/models/fee_model.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'dart:convert';

class FeeBottomSheet extends StatelessWidget {
  final String amountDetail;

  FeeBottomSheet({this.amountDetail});

  @override
  Widget build(BuildContext context) {
    final _detail =
        AmountDetail.fromJson(json.decode(amountDetail)['1']) ?? AmountDetail();
    return SizedBox(
      height: 300.0,
      child: LocalizedView(
        builder: (ctx, lang) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8),
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(lang.feeDetails, style: k16BoldStyle),
                  IconButton(
                    icon: Icon(CupertinoIcons.clear),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang.id, style: k16BoldStyle),
                      Text(
                          "${_detail?.id?.toString() ?? ''} (${_detail?.mode ?? ''})",
                          style: k14SimpleStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang.date, style: k16BoldStyle),
                      Text(_detail?.date ?? '', style: k14SimpleStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang.discount, style: k16BoldStyle),
                      Text(_detail?.discount ?? '', style: k14SimpleStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang.fine, style: k16BoldStyle),
                      Text(_detail?.fine ?? '', style: k14SimpleStyle),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lang.paid, style: k16BoldStyle),
                      Text(_detail?.amount ?? '', style: k14SimpleStyle),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_detail?.collectedBy ?? '', style: k14SimpleStyle),
            ),
          ],
        ),
      ),
    );
  }
}
