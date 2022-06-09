import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/features/authentication/domain/entities/user_entity.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveAuthenticationData(UserEntity user);

  Future<void> removeAuthenticationToken();
  Future<UserEntity?> getCachedUser();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final MySharedPreferences sharedPreferences;

  AuthenticationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserEntity?> getCachedUser() async {
    var userData = await sharedPreferences.getUser();
    if (userData != null) {
      return userData;
    } else {
      return null;
    }
  }

  @override
  Future<void> saveAuthenticationData(UserEntity user) async {
    await sharedPreferences.saveUser(user);
  }

  @override
  Future<void> removeAuthenticationToken() async {
    await sharedPreferences.removeUserData();
  }
}
