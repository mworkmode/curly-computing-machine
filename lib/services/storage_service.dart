import 'package:crypto_app/Model/user_model.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage();

  Future<void> saveUser(UserModel user) async {
    await box.write('user', user.toJson());
  }

  UserModel? getUser() {
    var userMap = box.read('user');
    if (userMap != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userMap));
    } else {
      return null;
    }
  }

  Future<void> clearUser() async {
    await box.remove('user');
  }
}
