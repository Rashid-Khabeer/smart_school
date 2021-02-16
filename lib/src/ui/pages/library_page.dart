import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/library_model.dart';
import 'package:smart_school/src/services/rest/library_service.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:toast/toast.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool _isLoading = true;
  List<LibraryIssued> _issued = [];
  LibraryIssuedResult _result = LibraryIssuedResult();

  _getData() async {
    ServerError _error;
    final _restResponse = await LibraryService()
        .getData(
      // authKey: AppData().readLastUser().token,
      // userId: AppData().readLastUser().userId,
      LibraryRequest(
        studentId: AppData().readLastUser().studentRecord.studentId,
      ),
    )
        .catchError((error) {
      print(error);
      Toast.show(error, context);
      _isLoading = true;
    });
    if (_error == null) {
      // _issued = _restResponse.data
      //     .map((dynamic i) => LibraryIssued.fromJson(i as Map<String, dynamic>))
      //     .toList();
      // if (_issued.isEmpty) {
      _result = LibraryIssuedResult.fromJson(_restResponse.data);
      // }
      print(_restResponse);
    }
    setState(() {});
    _isLoading = false;
  }

  Future<void> _fetchData() async => await _getData();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => Scaffold(
        appBar: AppBar(
          title: Text(lang.library),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _issued?.isEmpty ?? true
                    ? NoDataWidget(
                        message: _result.errorMsg,
                      )
                    : Text('Data'),
                // child: Text('Data'),
                // child: _schedule?.detail?.isEmpty ?? true
                //     ? NoDataWidget()
                //     : ListView.builder(
                //   itemCount: _schedule?.detail?.length ?? 0,
                //   itemBuilder: (context, index) => _RowItem(
                //     data: _schedule.detail[index],
                //   ),
                // ),
              ),
      ),
    );
  }
}
