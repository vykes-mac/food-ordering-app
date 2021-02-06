import 'package:auth/auth.dart';
import 'package:food_ordering_app/cache/local_store_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_TOKEN = 'CACHED_TOKEN';
const CACHED_AUTH = 'CACHED_AUTH';

class LocalStore implements ILocalStore {
  final SharedPreferences sharedPreferences;

  LocalStore(this.sharedPreferences);

  @override
  delete(Token token) {
    sharedPreferences.remove(CACHED_TOKEN);
  }

  @override
  Future<Token> fetch() {
    final tokenStr = sharedPreferences.getString(CACHED_TOKEN);
    if (tokenStr != null) return Future.value(Token(tokenStr));

    return null;
  }

  @override
  Future save(Token token) {
    return sharedPreferences.setString(CACHED_TOKEN, token.value);
  }

  @override
  Future<AuthType> fetchAuthType() {
    final authType = sharedPreferences.getString(CACHED_AUTH);
    if (authType != null) {
      return Future.value(
          AuthType.values.firstWhere((val) => val.toString() == authType));
    }
    return null;
  }

  @override
  Future saveAuthType(AuthType type) {
    return sharedPreferences.setString(CACHED_AUTH, type.toString());
  }
}
