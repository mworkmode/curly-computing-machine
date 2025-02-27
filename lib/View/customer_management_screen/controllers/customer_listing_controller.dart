import 'dart:developer';

import 'package:crypto_app/Model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';

class CustomerListingController extends GetxController{

  RxList<UserModel> userList = <UserModel>[].obs;
  TextEditingController dollarPriceController = TextEditingController();
  TextEditingController upiTextController = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref('Demo_data_app_custom');
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    usersListener();
    getMainData();
    super.onInit();
  }

  getMainData(){
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Demo_data_app_custom');
    starCountRef.get().then((value) {
      final data = value.value as Map<dynamic, dynamic>;
      final finalDta = Map<String, dynamic>.from(data);
      upiTextController.text = finalDta['myUPI'];
      dollarPriceController.text = finalDta['dollarPrice'];
    });
  }

  updateDollar() async{
    isLoading = true.obs;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Demo_data_app_custom');
    starCountRef.child('dollarPrice').set(dollarPriceController.text.toString()).then((value) {
      isLoading = false.obs;
      AppUtils.showSnackBar(title: 'Success', message: 'Dollar price updated for user');
    }).onError((error, stackTrace) {
      isLoading = false.obs;
      AppUtils.showSnackBar(title: 'Failed', message: 'Something went wrong');
    });
  }

  updateUpiData(){
    isLoading = true.obs;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Demo_data_app_custom');
    starCountRef.child('myUPI').set(upiTextController.text.toString()).then((value) {
      isLoading = false.obs;
      AppUtils.showSnackBar(title: 'Success', message: 'Data updated successfully');
    }).onError((error, stackTrace) {
      isLoading = false.obs;
      AppUtils.showSnackBar(title: 'Failed', message: 'Something went wrong');
    });
  }

  usersListener(){
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Demo_data_app');
    starCountRef.onValue.listen((DatabaseEvent event) async {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      log(data.toString());
      userList.value = data.values.map((user) {
        return UserModel.fromJson(Map<String, dynamic>.from(user));
      }).toList();
    });
  }
}