import 'package:async/async.dart';
import 'package:auth/auth.dart';
import 'package:cubit/cubit.dart';

import './auth_state.dart';
import '../../cache/local_store_contract.dart';
import '../../models/User.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILocalStore localStore;
  AuthCubit(this.localStore) : super(InitialState());

  signin(IAuthService authService, AuthType type) async {
    _startLoading();
    final result = await authService.signIn();
    localStore.saveAuthType(type);
    _setResultOfAuthState(result);
  }

  signout(IAuthService authService) async {
    _startLoading();
    final token = await localStore.fetch();
    final result = await authService.signOut(token);
    if (result.asValue.value) {
      localStore.delete(token);
      emit(SignOutSuccessState());
    } else {
      emit(ErrorState('Error signing out'));
    }
  }

  signup(ISignUpService signUpService, User user) async {
    _startLoading();
    final result = await signUpService.signUp(
      user.name,
      user.email,
      user.password,
    );
    _setResultOfAuthState(result);
  }

  void _setResultOfAuthState(Result<Token> result) {
    if (result.asError != null) {
      emit(ErrorState(result.asError.error));
    } else {
      localStore.save(result.asValue.value);
      emit(AuthSuccessState(result.asValue.value));
    }
  }

  void _startLoading() {
    emit(LoadingState());
  }
}
