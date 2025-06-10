import 'package:crypto_app/Model/user_model.dart';
import 'package:crypto_app/View/io.dart';
import 'package:crypto_app/utils/app_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../services/storage_service.dart';

class LoginController extends GetxController {

  final DatabaseReference _database = FirebaseDatabase.instance.ref('Demo_data_app');
  StorageService storageService = StorageService();
  RxBool isLoading = false.obs;
  bool emailExists = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  UserModel? userData;
  final _secureStorage = const FlutterSecureStorage();
  final RxBool rememberMe = false.obs;

  @override
  void onInit() {
    _loadSavedLogin();
    super.onInit();
  }

  void _loadSavedLogin() async {
    String? savedEmail = await _secureStorage.read(key: 'email');
    String? savedPassword = await _secureStorage.read(key: 'password');
    String? rememberMeFlag = await _secureStorage.read(key: 'remember_me');
    if (rememberMeFlag == 'true') {
      rememberMe.value = true;
      emailController.text = savedEmail ?? '';
      passwordController.text = savedPassword ?? '';
    }
  }

  Future<void> _handleRememberMe() async {
    if (rememberMe.value) {
      await _secureStorage.write(key: 'email', value: emailController.text);
      await _secureStorage.write(key: 'password', value: passwordController.text);
      await _secureStorage.write(key: 'remember_me', value: 'true');
    } else {
      await _secureStorage.deleteAll(); // Or selectively delete
    }
  }

  Future<UserModel?> login() async {
    isLoading.value = true;
    DatabaseReference usersRef = _database;

    Query query = usersRef.orderByChild('userEmail').equalTo(emailController.text.toString());
    DataSnapshot snapshot = await query.get();

    if (snapshot.exists) {
      var userMap = snapshot.value as Map<dynamic, dynamic>;
      var userId = userMap.keys.first;
      var user = userMap[userId];

      UserModel userObj = UserModel.fromJson(Map<String, dynamic>.from(user));
      if(userObj.userPassword.toString().trim() != passwordController.text.toString().trim()){
        isLoading.value = false;
        AppUtils.showSnackBar(title: 'Incorrect password', message: 'Please try again!');
        return null;
      }
      emailExists = true;
      userData = userObj;
      await storageService.saveUser(userObj);
      await _handleRememberMe();
      isLoading.value = false;
      Get.delete<LoginController>();
      Get.offAll(() => const IO());
      return userObj;
    } else {
      emailExists = false;
      userData = null;
      isLoading.value = false;
      AppUtils.showSnackBar(title: 'User not found', message: 'Please sign up');
      return null;
    }
  }

}