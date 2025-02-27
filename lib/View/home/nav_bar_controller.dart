import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../Model/user_model.dart';
import '../../services/storage_service.dart';

class NavBarController extends GetxController{

  StorageService storageService = StorageService();
  Rx<UserModel>? userData = UserModel().obs;
  RxString upiID = ''.obs;
  RxString dollarPrice = ''.obs;
  RxString code = ''.obs;

  @override
  void onInit() {
    code.value = dotenv.env['SECRETE_CODE'] ?? '';
    userData?.value = storageService.getUser()!;
    super.onInit();
    userDataListener();
    mainDataListener();
  }

  userDataListener(){
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Demo_data_app/${userData?.value.userId}');
    starCountRef.onValue.listen((DatabaseEvent event) async {
      final user = event.snapshot.value as Map<dynamic, dynamic>;
      UserModel userObj = UserModel.fromJson(Map<String, dynamic>.from(user));
      userData?.value = userObj;
      await storageService.saveUser(userObj);
    });
  }

  mainDataListener(){
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Demo_data_app_custom');
    starCountRef.onValue.listen((DatabaseEvent event) async {
      if(event.snapshot.value != null){
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        final finalDta = Map<String, dynamic>.from(data);
        upiID.value = finalDta['myUPI'];
        dollarPrice.value = finalDta['dollarPrice'];
      }
    });
  }

}