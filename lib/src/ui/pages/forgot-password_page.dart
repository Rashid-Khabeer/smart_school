import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/models/forgot-password_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/button_widget.dart';
import 'package:smart_school/src/ui/widgets/text-field_widget.dart';
import 'package:smart_school/src/utility/assets.dart';
import 'package:smart_school/src/utility/validators.dart';
import 'package:toast/toast.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _mode = AutovalidateMode.disabled;
  ForgotPasswordRequest _request = ForgotPasswordRequest();

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
                    AppTextField(
                      iconData: CupertinoIcons.mail,
                      onSaved: (value) => _request.email = value,
                      textInputType: TextInputType.emailAddress,
                      labelText: lang.username,
                      validator: emailValidator,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('I am'),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width - 30,
                      child: ToggleButtons(
                        isSelected: [
                          true,
                          false,
                        ],
                        constraints: BoxConstraints.expand(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 2 - 18,
                        ),
                        onPressed: (index) {},
                        children: [
                          Text('Student'),
                          Text('Parent'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: AppButtonWidget(
                        text: lang.login,
                        onPressed: _forgot,
                      ),
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

  _forgot() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ServerError _error;
      final _response = await RestService()
          .forgotPassword(
        request: _request,
      )
          .catchError((error) {
        print(error);
        _error = ServerError.withError(error);
        print(_error.errorMessage);
        Toast.show(_error.errorMessage, context);
      });
      if (_error == null) {
        Toast.show(_response.message, context);
      }
    } else
      setState(() => _mode = AutovalidateMode.onUserInteraction);
  }
}
