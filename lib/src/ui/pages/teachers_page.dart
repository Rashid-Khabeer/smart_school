import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/teachers_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/rating_dialog.dart';
import 'package:smart_school/src/ui/modals/teachers-bottom_sheet.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class TeachersPage extends StatefulWidget {
  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  bool _isLoading = true;
  Teachers _teachers = Teachers();
  List<TeachersData> _data = [];

  _getData() async {
    _isLoading = true;
    // setState(() {});
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
    if (_error == null) {
      _data.clear();
      _teachers.resultList.keys.forEach((key) {
        _data.add(TeachersData.fromJson(_teachers.resultList[key]));
      });
    }
    _isLoading = false;
    setState(() {});
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
                        itemBuilder: (context, index) {
                          return _RowItem(
                            data: _data[index],
                            lang: lang,
                          );
                        },
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final TeachersData data;
  final AppLocalizations lang;

  _RowItem({this.data, this.lang});

  @override
  Widget build(BuildContext context) {
    bool _isStudent = AppData().readLastUser().studentRecord.role == 'student';
    bool _isClassTeacher = int.parse(data.classTeacherId) > 0;
    Widget _ratingChild = Container();
    if (_isStudent) {
      if (data.rate == '0') {
        _ratingChild = TextButton(
          onPressed: () {
            openRatingDialog(
              context: context,
              staffId: data.staffId,
            );
          },
          child: Text(lang.addRating),
        );
      } else {
        _ratingChild = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: SmoothStarRating(
            starCount: 5,
            rating: double.parse(data.rate),
            isReadOnly: true,
            color: Colors.green,
            borderColor: Colors.green,
            spacing: 0.0,
            size: 15,
          ),
        );
      }
    }
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0),
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Icon(CupertinoIcons.person),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${data.staffName} ${data?.staffSurName ?? ''} (${data?.employeeId ?? ''})',
                    style: k16BoldStyle,
                  ),
                ),
                if (_isClassTeacher)
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Text(
                      lang.classTeacher,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                _ratingChild,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.email?.isNotEmpty ?? false)
                      Row(
                        children: [
                          Icon(CupertinoIcons.mail),
                          SizedBox(width: 5),
                          Text(data.email, style: k14Style),
                        ],
                      ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    Scaffold.of(context).showBottomSheet(
                      (context) => TeachersBottomSheet(
                        subjects: data.subjects,
                      ),
                    );
                  },
                  icon: Icon(CupertinoIcons.square_favorites),
                  label: Text(lang.view),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
