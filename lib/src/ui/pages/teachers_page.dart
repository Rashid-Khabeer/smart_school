import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/teachers_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:toast/toast.dart';

class TeachersPage extends StatefulWidget {
  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  bool _isLoading = true;
  Teachers _teachers = Teachers();
  List<TeachersData> _data = [];

  _getData() async {
    ServerError _error;
    _teachers = await RestService()
        .getTeachersList(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: TeachersRequest(
        userId: AppData().readLastUser().userId,
        classId: AppData().getClassId(),
        sectionId: AppData().getSectionId(),
      ),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, context);
      _isLoading = true;
    });
    _teachers.resultList.keys.forEach((key) {
      _data.add(TeachersData.fromJson(_teachers.resultList[key]));
    });
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
          title: Text(lang.reviews),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _data?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _data?.length ?? 0,
                        itemBuilder: (context, index) =>
                            Text(_data[index].email),
                        // _RowItem(
                        // data: _examination.detail[index],
                        // ),
                      ),
              ),
      ),
    );
  }
}
