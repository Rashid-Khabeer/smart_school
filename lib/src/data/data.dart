import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_school/src/data/mixins/auth_mixin.dart';
import 'package:smart_school/src/data/mixins/locale_mixin.dart';
import 'package:smart_school/src/data/mixins/shared-preferences_mixin.dart';
import 'package:smart_school/src/data/models/sign-in_model.dart';

class AppData with LocaleData, AuthMixin, SharedPreferencesMixin {
  AppData._();

  static bool _isInitiated;

  static Future initiate() async {
    await Hive.initFlutter();

    Hive.registerAdapter(SignInResponseAdapter());
    Hive.registerAdapter(StudentRecordAdapter());
    Hive.registerAdapter(LanguageAdapter());
    await SharedPreferencesMixin.initialize();
    await AuthMixin.initialize();
    await LocaleData.initiate();

    _isInitiated = true;
  }

  factory AppData() {
    if (_isInitiated) {
      return AppData._();
    } else {
      throw 'AppData has not been initialized';
    }
  }
}
