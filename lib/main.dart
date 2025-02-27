import 'package:crypto_app/View/login/login_page.dart';
import 'package:crypto_app/View/options/options_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OptionsController());
    return const GetMaterialApp(
      title: "DeltaX",
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}


