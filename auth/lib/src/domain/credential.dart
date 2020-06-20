import 'package:flutter/foundation.dart';

class Credential {
  final AuthType type;
  final String name;
  final String email;
  final String password;

  Credential({
    @required this.type,
    this.name,
    @required this.email,
    this.password,
  });
}

enum AuthType { email, google }
