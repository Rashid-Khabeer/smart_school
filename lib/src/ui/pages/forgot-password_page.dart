import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/models/forgot-password_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/loading_dialog.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/button_widget.dart';
import 'package:smart_school/src/ui/widgets/text-field_widget.dart';
import 'package:smart_school/src/utility/assets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/validators.dart';
import 'package:toast/toast.dart';

const Map<String, String> userTypes = {
  'Student': 'student',
  'Parent': 'parent',
};

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _mode = AutovalidateMode.disabled;
  ForgotPasswordRequest _request = ForgotPasswordRequest();

  @override
  void initState() {
    super.initState();
    _request.userType = userTypes['Student'];
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (ctx, lang) => SafeArea(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: AppTextField(
                        iconData: CupertinoIcons.mail,
                        onSaved: (value) => _request.email = value,
                        textInputType: TextInputType.emailAddress,
                        labelText: 'Email',
                        validator: emailValidator,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'I am',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      child: ToggleButtons(
                        constraints: BoxConstraints.expand(
                          height: 35,
                          width: MediaQuery.of(context).size.width / 2 - 23,
                        ),
                        fillColor: Colors.white,
                        selectedColor: kMainColor,
                        color: kMainColor,
                        isSelected: userTypes.keys
                            .map((e) => _request.userType == userTypes[e])
                            .toList(),
                        onPressed: (index) {
                          setState(() => _request.userType =
                              userTypes.values.elementAt(index));
                        },
                        children: userTypes.keys
                            .map(
                              (e) => Text(
                                e,
                                style: TextStyle(
                                  color: _request.userType == userTypes[e]
                                      ? kMainColor
                                      : Colors.white,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: AppButtonWidget(
                        text: 'Submit',
                        onPressed: _forgot,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _forgot() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      openLoadingDialog(context: context);
      ServerError _error;
      final _response = await RestService()
          .forgotPassword(
        request: _request,
      )
          .catchError((error) {
        print(error);
        _error = ServerError.withError(error);
        print(_error.errorMessage);
        Toast.show(
          _error.errorMessage,
          context,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          duration: 3,
        );
      });
      if (_error == null) {
        Toast.show(
          _response.message,
          context,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          duration: 3,
        );
      }
      Navigator.of(context).pop();
    } else
      setState(() => _mode = AutovalidateMode.onUserInteraction);
  }
}
