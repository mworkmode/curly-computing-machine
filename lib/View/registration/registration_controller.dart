import 'package:crypto_app/Model/user_model.dart';
import 'package:crypto_app/View/login/login_page.dart';
import 'package:crypto_app/utils/app_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RegistrationController extends GetxController {

  DatabaseReference ref = FirebaseDatabase.instance.ref('Demo_data_app');
  Uuid uuid = const Uuid();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final panNumberController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscNumberController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxString code = ''.obs;

  @override
  void onInit() {
    code.value = dotenv.env['SECRETE_CODE'] ?? '';
    super.onInit();
  }

  void submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isLoading.value = true;
      bool userStatus = false;
      bool isExists = await checkIfUserExists();
      if(!isExists){
        String userId = uuid.v4();
        if(passwordController.text.toString().trim() == code.value.toString().trim()){
          userStatus = true;
        }
        UserModel userData = UserModel(
          userId: userId,
          userName: userNameController.text.toString().trim(),
          userEmail: emailController.text.toString().trim(),
          userStatus: userStatus,
          userPassword: passwordController.text.toString().trim(),
          userPanNumber: panNumberController.text.toString().trim(),
          userAccountNumber: accountNumberController.text.toString().trim(),
          userIFSCCode: ifscNumberController.text.toString().trim(),
          accountFundValue: 0,
          todayGain: 0,
          todayLoss: 0,
          totalValue: 0,
          overallGainOrLoss: 0,
          dollarPrice: 0,
          mobileNumber: mobileNumberController.text.toString().trim(),
        );
        ref.child(userId).set(userData.toJson()).then((value) async {
          isLoading.value = false;
          AppUtils.showSnackBar(title: 'Registration Successful', message: 'Please login!');
          Get.delete<RegistrationController>();
          Get.offAll(() => const LoginPage());
        }).onError((error, stackTrace) {
          isLoading.value = false;
          AppUtils.showSnackBar(title: 'Something went wrong', message: 'Please try again later!');
        });
      }else{
        isLoading.value = false;
        AppUtils.showSnackBar(title: 'Email already exists', message: 'User another email address!');
      }
    }
  }

  Future<bool> checkIfUserExists() async{
    bool exists = false;
    try{
      await ref.get().then((dataSnapShot) {
        if(dataSnapShot.value != null){
          final Map<dynamic,dynamic> values = dataSnapShot.value as Map<dynamic,dynamic>;
          values.forEach((key, value) {
            final UserModel user = UserModel.fromJson(Map<String, dynamic>.from(value as Map));
            if(user.userEmail == emailController.text.toString().trim()){
              exists = true;
            }
          });
        }
      });
      return exists;
    }on Exception catch(e,s){
      e;
      s;
    }
    return exists;
  }
}