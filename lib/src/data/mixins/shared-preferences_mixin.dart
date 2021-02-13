import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPreferencesMixin {
  static SharedPreferences _preferences;
  static final _classId = 'classId';
  static final _sectionId = 'sectionId';
  static final _locale = 'locale';

  static Future<void> initialize() async =>
      _preferences = await SharedPreferences.getInstance();

  containsClassId() => _preferences.containsKey(_classId);

  containsSectionId() => _preferences.containsKey(_sectionId);

  static containLocate() => _preferences.containsKey(_locale);

  containsIds() => (containsSectionId() && containsSectionId());

  setLocale(String locale) => _preferences.setString(_locale, locale);

  static getLocale() => containLocate() ? _preferences.getString(_locale) : '';

  setClassId(String classId) {
    if (!containsClassId()) _preferences.setString(_classId, classId);
  }

  getClassId() => containsClassId() ? _preferences.getString(_classId) : '';

  setSectionId(String sectionId) {
    if (!containsSectionId()) _preferences.setString(_sectionId, sectionId);
  }

  getSectionId() =>
      containsSectionId() ? _preferences.getString(_sectionId) : '';

  clearIds() {
    if (containsClassId()) _preferences.remove(_classId);
    if (containsSectionId()) _preferences.remove(_sectionId);
  }
}
