import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/api/database_api.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/app_user_trans.dart';

class UserService {
  final _authApi = AuthApi();
  final _databaseApi = DatabaseApi();

  AppUser? _currentUser;
  AppUserTransalted? _currentUserTrans;

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

  Future getAuthUser() async {
    final userId = _authApi.currentUser!.uid;
    final userAccount = await _databaseApi.getUserLogin(userId);

    if (userAccount.id != '123') {
      _currentUser = userAccount;
      return _currentUser;
    }
    return null;
  }

  Future getAuthUser1() async {
    final userId = _authApi.currentUser!.uid;
    final userAccount = await _databaseApi.getUserLogin1(userId);

    if (userAccount.id != '123') {
      _currentUserTrans = userAccount;
      return _currentUserTrans;
    }
    return null;
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

  Future<void> updateUser({
    required id,
    required user,
  }) async {
    await _databaseApi.updateUser(id, user);
  }
}
