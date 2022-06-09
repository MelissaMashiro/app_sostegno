import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/features/authentication/domain/entities/user_entity.dart';

const String kUser = 'user';

class MySharedPreferencesImpl implements MySharedPreferences {
  //MySharedPreferencesImpl() : _sharedPreferences = SharedPreferences();
  //final SharedPreferences _sharedPreferences;

  @override
  Future<UserEntity?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(kUser);

    if (userData != null) {
      return UserEntity.fromMap(jsonDecode(userData));
    } else {
      return null;
    }
  }

  @override
  Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(kUser);
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUser, user.toJson());
  }
}
