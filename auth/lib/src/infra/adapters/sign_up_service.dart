import 'package:async/async.dart';
import 'package:auth/auth.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';

import '../../domain/credential.dart';

class SignUpService implements ISignUpService {
  final IAuthApi _api;

  SignUpService(this._api);

  @override
  Future<Result<Token>> signUp(
    String name,
    String email,
    String password,
  ) async {
    Credential credential = Credential(
      type: AuthType.email,
      email: email,
      name: name,
      password: password,
    );

    var result = await _api.signUp(credential);
    if (result.isError) return result.asError;
    return Result.value(Token(result.asValue.value));
  }
}
