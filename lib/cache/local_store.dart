import 'package:auth/auth.dart';
import 'package:food_ordering_app/cache/local_store_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_TOKEN = 'CACHED_TOKEN';

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
}
