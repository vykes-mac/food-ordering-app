import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:food_ordering_app/cache/local_store.dart';
import 'package:food_ordering_app/states_management/auth/auth_cubit.dart';
import 'package:food_ordering_app/ui/pages/auth/auth_page.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache/local_store_contract.dart';

class CompositionRoot {
  static SharedPreferences _sharedPreferences;
  static ILocalStore _localStore;
  static String _baseUrl;
  static Client _client;

  static configure() {
    _localStore = LocalStore(_sharedPreferences);
    _client = Client();
    _baseUrl = "http://localhost:3000";
  }

  static Widget composeAuthUi() {
    IAuthApi _api = AuthApi(_baseUrl, _client);
    AuthManager _manger = AuthManager(_api);
    AuthCubit _authCubit = AuthCubit(_localStore);
    ISignUpService _signupService = SignUpService(_api);

    return CubitProvider(
      create: (BuildContext context) => _authCubit,
      child: AuthPage(_manger, _signupService),
    );
  }
}
