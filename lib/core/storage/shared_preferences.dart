import 'package:app_sostegno/features/authentication/domain/authentication_domain.dart';

abstract class MySharedPreferences {
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getUser();
  Future<void> removeUserData();
}
