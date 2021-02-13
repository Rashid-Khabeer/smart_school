import 'package:flutter/material.dart';
import 'package:smart_school/src/data/mixins/shared-preferences_mixin.dart';

mixin LocaleData {
  static final locale = ValueNotifier<Locale>(null);

  static Future<void> initiate() async {
    locale.value = Locale.fromSubtags(
      languageCode: SharedPreferencesMixin?.getLocale()?.isEmpty ?? true
          ? 'en'
          : SharedPreferencesMixin.getLocale(),
    );
  }

  void changeLocale(Locale locale) => LocaleData.locale.value = locale;
}
