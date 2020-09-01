import 'package:async/async.dart';

import './token.dart';

abstract class IAuthService {
  Future<Result<Token>> signIn();
  Future<Result<bool>> signOut(Token token);
}
