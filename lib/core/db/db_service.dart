import 'package:event_user/features/auth/domain/entity/user_entity.dart';
import 'package:get_storage/get_storage.dart';

class DbService {
  final _storage = GetStorage();
  String getToken() => _storage.read("token") ?? "";
  String getName() => _storage.read("name") ?? "";
  String getEamil() => _storage.read("email") ?? "";
  String getPhone() => _storage.read("phone") ?? "";

  Future saveCred(UserEntity data) async {
    await Future.wait([
      _storage.write("token", data.token),
      _storage.write("name", data.name),
      _storage.write("phone", data.phone),
      _storage.write("email", data.email),
    ]);
  }

  Map<String, String> getCred() => {
    "name": _storage.read("name") ?? "",
    "email": _storage.read("email") ?? "",
    "phone": _storage.read("phone") ?? "",
  };

  Future clearCred() async {
    await Future.wait([
      _storage.remove("token"),
      _storage.remove("name"),
      _storage.remove("phone"),
      _storage.remove("email"),
    ]);
  }
}
