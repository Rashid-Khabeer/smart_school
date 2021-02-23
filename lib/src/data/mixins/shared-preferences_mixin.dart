import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPreferencesMixin {
  static SharedPreferences _preferences;
  static final _classId = 'classId';
  static final _sectionId = 'sectionId';
  static final _locale = 'locale';
  static final _parentIndex = 'parentIndex';

  static Future<void> initialize() async =>
      _preferences = await SharedPreferences.getInstance();

  containsClassId() => _preferences.containsKey(_classId);

  containsParentChildIndex() => _preferences.containsKey(_parentIndex);

  containsSectionId() => _preferences.containsKey(_sectionId);

  static containLocate() => _preferences.containsKey(_locale);

  containsIds() => (containsSectionId() && containsSectionId());

  setLocale(String locale) async =>
      await _preferences.setString(_locale, locale);

  setParentChildIndex(int index) async =>
      await _preferences.setInt(_parentIndex, index);

  static getLocale() => containLocate() ? _preferences.getString(_locale) : '';

  setClassId(String classId) async =>
      await _preferences.setString(_classId, classId);

  getParentChildIndex() =>
      containsParentChildIndex() ? _preferences.getInt(_parentIndex) : 1;

  getClassId() => containsClassId() ? _preferences.getString(_classId) : '';

  setSectionId(String sectionId) async =>
      await _preferences.setString(_sectionId, sectionId);

  getSectionId() =>
      containsSectionId() ? _preferences.getString(_sectionId) : '';

  clearIds() => _preferences.clear();
}
