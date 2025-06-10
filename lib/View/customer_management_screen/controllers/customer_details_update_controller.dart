import 'package:crypto_app/Model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';

class CustomerDetailsUpdateController extends GetxController{
  var arguments = Get.arguments;
  RxBool enableEdit = false.obs;

  UserModel userData = UserModel();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final panNumberController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscNumberController = TextEditingController();
  final mobileNumberController = TextEditingController();

  final accountFundValueController = TextEditingController();
  final totalValueController = TextEditingController();
  final todayGainController = TextEditingController();
  final todayLossController = TextEditingController();
  final overallGainOrLossController = TextEditingController();

  final aadharController = TextEditingController();
  final limitValueController = TextEditingController();
  final positionValueController = TextEditingController();
  final completeProfitController = TextEditingController();
  final completeLossController = TextEditingController();


  final formKey = GlobalKey<FormState>();
  RxBool obscured = true.obs;
  RxBool isLoading = false.obs;

  RxBool isUserActive = true.obs;
  String userId = '';
  RxString code = ''.obs;

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  @override
  void onInit() {
    super.onInit();
    code.value = dotenv.env['SECRETE_CODE'] ?? '';
    if(arguments != null){
      userData = arguments['user'];
      userId = userData.userId ?? '';
      isUserActive.value = userData.userStatus ?? false;
      userNameController.text = userData.userName ?? '';
      emailController.text = userData.userEmail ?? '';
      passwordController.text = userData.userPassword ?? '';
      panNumberController.text = userData.userPanNumber ?? '';
      accountNumberController.text = userData.userAccountNumber ?? '';
      ifscNumberController.text = userData.userIFSCCode ?? '';
      mobileNumberController.text = userData.mobileNumber ?? '';
      accountFundValueController.text = userData.accountFundValue.toString();
      totalValueController.text = userData.totalValue.toString();
      todayGainController.text = userData.todayGain.toString();
      todayLossController.text = userData.todayLoss.toString();
      overallGainOrLossController.text = userData.overallGainOrLoss.toString();
      aadharController.text = userData.userAadharNumber.toString();
      limitValueController.text = userData.limitValue.toString();
      positionValueController.text = userData.positionValue.toString();
      completeProfitController.text = userData.totalProfit.toString();
      completeLossController.text = userData.totalLoss.toString();
    }
  }

  void submitForm(BuildContext context) async {
    UserModel userDataUpdated = UserModel(
      userId: userId,
      userName: userNameController.text.toString().trim(),
      userEmail: emailController.text.toString().trim(),
      userStatus: isUserActive.value,
      userPassword: passwordController.text.toString().trim(),
      userPanNumber: panNumberController.text.toString().trim(),
      userAccountNumber: accountNumberController.text.toString().trim(),
      userIFSCCode: ifscNumberController.text.toString().trim(),
      accountFundValue: double.parse(accountFundValueController.text.toString().trim()),
      todayGain: double.parse(todayGainController.text.toString().trim()),
      todayLoss: double.parse(todayLossController.text.toString().trim()),
      totalValue: double.parse(totalValueController.text.toString().trim()),
      overallGainOrLoss: double.parse(overallGainOrLossController.text.toString().trim()),
      dollarPrice: userData.dollarPrice,
      mobileNumber: mobileNumberController.text.toString().trim(),
      limitValue: double.parse(limitValueController.text.toString().trim()),
      portfolioList: userData.portfolioList,
      positionValue: double.parse(positionValueController.text.toString().trim()),
      totalLoss: double.parse(completeLossController.text.toString().trim()),
      totalProfit: double.parse(completeProfitController.text.toString().trim()),
      userAadharNumber: aadharController.text.toString().trim()
    );
    updateUserData(userId, userDataUpdated.toJson());
  }

  void updateUserData(String userId, Map<String, dynamic> newUserData) async {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child('Demo_data_app').child(userId);
    await userRef.update(newUserData);
    Get.back();
    AppUtils.showSnackBar(title: 'Success', message: 'User data updated successfully');
  }

}