import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/models/teachers_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/utility/constants.dart';

// ignore: must_be_immutable
class TeachersBottomSheet extends StatelessWidget {
  final List<TeachersSubject> subjects;
  AppLocalizations lang;

  TeachersBottomSheet({this.subjects});

  @override
  Widget build(BuildContext context) {
    lang = AppLocalizations.of(context);
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(CupertinoIcons.clear),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text(lang.time, style: k16BoldStyle)),
                    DataColumn(label: Text(lang.day, style: k16BoldStyle)),
                    DataColumn(label: Text(lang.subject, style: k16BoldStyle)),
                    DataColumn(label: Text(lang.room, style: k16BoldStyle)),
                  ],
                  rows: subjects?.isNotEmpty ?? false ? _getDataRow() : [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getDataRow() {
    return subjects.map((e) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              e.timeFrom != ''
                  ? '${e.timeFrom} - \n${e.timeTo}'
                  : lang.noScheduled,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              e.day,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              e.subjectName,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
          DataCell(
            Text(
              e.roomNo,
              style: k14Style.copyWith(color: Colors.grey.shade600),
            ),
          ),
        ],
      );
    }).toList();
  }
}
