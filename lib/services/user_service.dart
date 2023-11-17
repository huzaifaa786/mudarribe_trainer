import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/api/database_api.dart';
import 'package:mudarribe_trainer/models/app_user.dart';

class UserService {
  final _authApi = AuthApi();
  final _databaseApi = DatabaseApi();

  AppUser? _currentUser;

  AppUser get currentUser => _currentUser!;

  Future<bool> syncUser() async {
    final userId = _authApi.currentUser!.uid;
    final userAccount = await _databaseApi.getUserLogin(userId);

    if (userAccount.id != '123') {
      _currentUser = userAccount;
      return true;
    }
    return false;
  }

  Future<void> syncOrCreateUser({
    required AppUser user,
  }) async {
    await syncUser().then((value) async {
      if (/*_currentUser == null*/ value == false) {
        await _databaseApi.createUser(user);
      } else {}
    });
  }
}