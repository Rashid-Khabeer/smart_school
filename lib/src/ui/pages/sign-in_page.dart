import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/sign-in_model.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/language_dialog.dart';
import 'package:smart_school/src/ui/modals/loading_dialog.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/button_widget.dart';
import 'package:smart_school/src/ui/widgets/text-field_widget.dart';
import 'package:smart_school/src/utility/assets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/nav.dart';
import 'package:smart_school/src/utility/validators.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInRequest _request = SignInRequest();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _mode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging().getToken().then((value) {
      _request.deviceToken = value;
      print('Firebase Device Token: $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) => SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.loginBackground),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: _mode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Image.asset(AppAssets.logo, width: 170),
                    SizedBox(height: 20.0),
                    AppTextField(
                      iconData: CupertinoIcons.person,
                      onSaved: (value) => _request.userName = value,
                      textInputType: TextInputType.name,
                      labelText: lang.username,
                      validator: Validators.required,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
                      child: AppPasswordField(
                        onSaved: (value) => _request.password = value,
                        labelText: lang.password,
                        validator: Validators.required,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: AppButtonWidget(
                        text: lang.login,
                        onPressed: _signIn,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        _dividerWidget(),
                        InkWell(
                          onTap: () => print('Hello'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              lang.forgot,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        _dividerWidget(),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _privacyAction,
                          child: Text(
                            lang.privacy,
                            style: k16BoldStyle.copyWith(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => openLanguageDialog(context: context),
                          child: Icon(
                            CupertinoIcons.globe,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _dividerWidget() {
    return Expanded(
      child: Divider(
        color: Colors.white,
        thickness: 2,
      ),
    );
  }

  _privacyAction() async {
    const url = kDomainUrl + kPrivacyPolicy;
    if (await canLaunch(url))
      await launch(url);
    else
      throw 'Could not launch $url';
  }

  _signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      openLoadingDialog(context: context);
      ServerError _error;
      SignInResponse _response =
          await RestService().signIn(_request).catchError((error) {
        print(error);
        _error = ServerError.withError(error);
        print(_error.errorMessage);
      });
      if (_error == null) {
        Navigator.of(context).pop();
        await AppData().saveUser(_response);
        ServerError _error;
        StudentProfile _profile = await RestService()
            .getProfile(
          authKey: AppData().readLastUser().token,
          userId: AppData().readLastUser().userId,
          request: StudentRequest(
              id: AppData().readLastUser().studentRecord.studentId),
        )
            .catchError((error) {
          print(error);
          _error = ServerError.withError(error);
          print(_error.errorMessage);
          Toast.show(_error.errorMessage, context);
        });
        AppData().setClassId(_profile.studentResult.classId);
        AppData().setSectionId(_profile.studentResult.sectionId);
        Navigator.of(context).pop();
        AppNavigation.toPage(context, AppPage.home);
      } else
        Toast.show(
          _error.errorMessage,
          context,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          duration: 3,
        );
    } else
      setState(() => _mode = AutovalidateMode.onUserInteraction);
  }
}
