import 'package:async/async.dart';

import '../../domain/credential.dart';
import '../../domain/token.dart';

abstract class IAuthApi {
  Future<Result<String>> signIn(Credential credential);
  Future<Result<String>> signUp(Credential credential);
  Future<Result<bool>> signOut(Token token);
}
