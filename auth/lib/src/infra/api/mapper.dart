import '../../domain/credential.dart';

class Mapper {
  static Map<String, dynamic> toJson(Credential credential) => {
        "type": credential.type,
        "name": credential.name,
        "email": credential.email,
        "password": credential.password
      };
}
