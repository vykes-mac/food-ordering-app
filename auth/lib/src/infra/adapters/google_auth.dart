import 'package:async/async.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/auth_service_contract.dart';
import '../../domain/credential.dart';
import '../../domain/token.dart';
import '../../infra/api/auth_api_contract.dart';

class GoogleAuth implements IAuthService {
  final IAuthApi _authApi;
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount _currentUser;

  GoogleAuth(this._authApi, [GoogleSignIn googleSignIn])
      : this._googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: ['email', 'profile'],
            );

  @override
  Future<Result<Token>> signIn() async {
    await _handleGoogleSignIn();
    if (_currentUser == null)
      return Result.error('Failed to signin with Google');
    Credential credential = Credential(
        type: AuthType.google,
        email: _currentUser.email,
        name: _currentUser.displayName);
    var result = await _authApi.signIn(credential);
    if (result.isError) return result.asError;

    return Result.value(Token(result.asValue.value));
  }

  @override
  Future<void> signOut() async {
    _googleSignIn.disconnect();
  }

  _handleGoogleSignIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();
    } catch (error) {
      return;
    }
  }
}
