import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  StudentProfile _profile = StudentProfile();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _getData();
  }

  _getData() async {
    ServerError _error;
    print(AppData().readLastUser().studentRecord.studentId);
    _profile = await RestService()
        .getProfile(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request:
          StudentRequest(id: AppData().readLastUser().studentRecord.studentId),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, context);
    });
    setState(() {});
  }

  // Future<void> _fetchData() async => await _getData();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 15.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: ClipOval(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: _profile?.studentResult?.image?.isEmpty ?? true
                            ? Icon(CupertinoIcons.person)
                            : Image.network(kDomainUrl +
                                    '/' +
                                    _profile?.studentResult?.image ??
                                ''),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_profile?.studentResult?.firstName ?? '',
                          style: k16BoldStyle),
                      Text(
                          '${lang.className(_profile?.studentResult?.className ?? '')}',
                          style: k14Style),
                      Text(
                          '${lang.admNo(_profile?.studentResult?.admissionNo ?? '')}',
                          style: k14Style),
                      Text(
                          '${lang.rollNo(_profile?.studentResult?.rollNo ?? '')}',
                          style: k14Style),
                    ],
                  ),
                ),
              ],
            ),
            TabBar(
              indicatorColor: kMainColor,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text('Personal', style: kSimpleStyle),
                ),
                Tab(
                  child: Text('Parents', style: kSimpleStyle),
                ),
                Tab(
                  child: Text('Other', style: kSimpleStyle),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _PersonalView(
                      studentResult:
                          _profile?.studentResult ?? StudentResult()),
                  _ParentsView(
                      studentResult:
                          _profile?.studentResult ?? StudentResult()),
                  _OtherView(
                      studentResult:
                          _profile?.studentResult ?? StudentResult()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonalView extends StatelessWidget {
  final StudentResult studentResult;

  _PersonalView({this.studentResult});

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _RowWidget(
                title: lang.admissionDate,
                subTitle: studentResult?.admissionDate ?? '',
                width: 45.0,
              ),
              _RowWidget(
                title: lang.dob,
                subTitle: studentResult?.dob ?? '',
                width: 65.0,
              ),
              _RowWidget(
                title: lang.category,
                subTitle: studentResult?.category ?? '',
                width: 86.0,
              ),
              _RowWidget(
                title: lang.mobileNo,
                subTitle: studentResult?.mobileNo ?? '',
                width: 47.0,
              ),
              _RowWidget(
                title: lang.caste,
                subTitle: studentResult?.cast ?? '',
                width: 106.0,
              ),
              _RowWidget(
                title: lang.religion,
                subTitle: studentResult?.religion ?? '',
                width: 91.0,
              ),
              _RowWidget(
                title: lang.email,
                subTitle: studentResult?.email ?? '',
                width: 108.0,
              ),
              _RowWidget(
                title: lang.currentAddress,
                subTitle: studentResult?.currentAddress ?? '',
                width: 40.0,
              ),
              _RowWidget(
                title: lang.permanentAddress,
                subTitle: studentResult?.permanentAddress ?? '',
                width: 17.0,
              ),
              _RowWidget(
                title: lang.bloodGroup,
                subTitle: studentResult?.bloodGroup ?? '',
                width: 65.0,
              ),
              _RowWidget(
                title: lang.height,
                subTitle: studentResult?.height ?? '',
                width: 100.0,
              ),
              _RowWidget(
                title: lang.weight,
                subTitle: studentResult?.weight ?? '',
                width: 105.0,
              ),
              _RowWidget(
                title: lang.asOnDate,
                subTitle: studentResult?.measurementDate ?? '',
                width: 70.0,
              ),
              _RowWidget(
                title: lang.medicalHistory,
                subTitle: '',
                width: 43.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final double width;

  _RowWidget({this.title, this.subTitle, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: [
          Text(title, style: k14Style),
          SizedBox(width: width),
          Flexible(
            child: Text(subTitle, style: k14Style),
          ),
        ],
      ),
    );
  }
}

class _ParentsView extends StatelessWidget {
  final StudentResult studentResult;

  _ParentsView({this.studentResult});

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: ClipOval(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: studentResult?.fatherPic?.isEmpty ?? true
                                    ? Icon(CupertinoIcons.person)
                                    : Image.network(kDomainUrl +
                                            '/' +
                                            studentResult?.fatherPic ??
                                        ''),
                              ),
                            ),
                          ),
                          Text(lang.father, style: k16BoldStyle),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Row1Item(
                          title: studentResult?.fatherName ?? '',
                          icon: CupertinoIcons.person_alt,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: _Row1Item(
                            title: studentResult?.fatherPhone ?? '',
                            icon: CupertinoIcons.phone_fill,
                          ),
                        ),
                        _Row1Item(
                          title: studentResult?.fatherOccupation ?? '',
                          icon: CupertinoIcons.bag_fill,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: ClipOval(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: studentResult?.motherPic?.isEmpty ?? true
                                    ? Icon(CupertinoIcons.person)
                                    : Image.network(kDomainUrl +
                                            '/' +
                                            studentResult?.motherPic ??
                                        ''),
                              ),
                            ),
                          ),
                          Text(lang.mother, style: k16BoldStyle),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Row1Item(
                          title: studentResult?.motherName ?? '',
                          icon: CupertinoIcons.person_alt,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: _Row1Item(
                            title: studentResult?.motherPhone ?? '',
                            icon: CupertinoIcons.phone_fill,
                          ),
                        ),
                        _Row1Item(
                          title: studentResult?.motherOccupation ?? '',
                          icon: CupertinoIcons.bag_fill,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: ClipOval(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child:
                                    studentResult?.guardianPic?.isEmpty ?? true
                                        ? Icon(CupertinoIcons.person)
                                        : Image.network(kDomainUrl +
                                                '/' +
                                                studentResult?.guardianPic ??
                                            ''),
                              ),
                            ),
                          ),
                          Text(lang.guardian, style: k16BoldStyle),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Row1Item(
                          title: studentResult?.guardianName ?? '',
                          icon: CupertinoIcons.person_alt,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: _Row1Item(
                            title: studentResult?.guardianPhone ?? '',
                            icon: CupertinoIcons.phone_fill,
                          ),
                        ),
                        _Row1Item(
                          title: studentResult?.guardianOccupation ?? '',
                          icon: CupertinoIcons.bag_fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: _Row1Item(
                            title: studentResult?.guardianRelation ?? '',
                            icon: CupertinoIcons.person_2_fill,
                          ),
                        ),
                        _Row1Item(
                          title: studentResult?.guardianEmail ?? '',
                          icon: CupertinoIcons.mail_solid,
                        ),
                        SizedBox(height: 5.0),
                        _Row1Item(
                          title: studentResult?.guardianAddress ?? '',
                          icon: CupertinoIcons.location_solid,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row1Item extends StatelessWidget {
  final IconData icon;
  final String title;

  _Row1Item({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18),
        SizedBox(width: 10.0),
        Text(title, style: k14Style),
      ],
    );
  }
}

class _OtherView extends StatelessWidget {
  final StudentResult studentResult;

  _OtherView({this.studentResult});

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _RowWidget(
                title: lang.previousSchool,
                subTitle: studentResult?.previousSchool ?? '',
                width: 45.0,
              ),
              _RowWidget(
                title: lang.nic,
                subTitle: studentResult?.adharNo ?? '',
                width: 65.0,
              ),
              _RowWidget(
                title: lang.localId,
                subTitle: studentResult?.samagraId ?? '',
                width: 86.0,
              ),
              _RowWidget(
                title: lang.bankNo,
                subTitle: studentResult?.bankAccountNo ?? '',
                width: 47.0,
              ),
              _RowWidget(
                title: lang.bankName,
                subTitle: studentResult?.bankName ?? '',
                width: 106.0,
              ),
              _RowWidget(
                title: lang.ifsc,
                subTitle: studentResult?.ifscCode ?? '',
                width: 91.0,
              ),
              _RowWidget(
                title: lang.rte,
                subTitle: studentResult?.rte ?? '',
                width: 108.0,
              ),
              _RowWidget(
                title: lang.vehicleRoute,
                subTitle: studentResult?.routeTitle ?? '',
                width: 40.0,
              ),
              _RowWidget(
                title: lang.vehicleNo,
                subTitle: studentResult?.vehicleNo ?? '',
                width: 17.0,
              ),
              _RowWidget(
                title: lang.driverName,
                subTitle: studentResult?.driverName ?? '',
                width: 65.0,
              ),
              _RowWidget(
                title: lang.driverContact,
                subTitle: studentResult?.driverContact ?? '',
                width: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
