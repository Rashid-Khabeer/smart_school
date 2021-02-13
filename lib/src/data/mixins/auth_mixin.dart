import 'package:hive/hive.dart';
import 'package:smart_school/src/data/models/sign-in_model.dart';

mixin AuthMixin {
  static Box<SignInResponse> _box;

  static Future<void> initialize() async {
    _box = await Hive.openBox<SignInResponse>('user');
  }

  bool isUserSaved() => _box.isNotEmpty;

  SignInResponse readLastUser() {
    if (_box.isEmpty)
      throw ('');
    else
      return _box.values.last;
  }

  clearData() async {
    if (_box.isNotEmpty) await _box.clear();
  }

  Future<void> saveUser(SignInResponse userData) async {
    _box.add(userData);
    await userData.save();
  }
}
