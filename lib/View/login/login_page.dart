import 'package:crypto_app/View/login/login_controller.dart';
import 'package:crypto_app/constants/custom_form_button.dart';
import 'package:crypto_app/constants/custom_input_field.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/functions.dart';
import '../registration/registrationpage.dart';
import '../io.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final LoginController controller = Get.put(LoginController());
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(15, 30, 16, 0),
                child: SingleChildScrollView(
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 50,),
                        const Text(
                          "Login Now",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Please login to continue using our app.",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        CustomEmailInputField(
                          controller: controller.emailController,
                          isDense: true,
                          labelText: 'Email',
                          hintText: 'Enter email address',
                          validator: (textValue) {
                            if(textValue != null) {
                              textValue = textValue.trim();
                              if (textValue.isEmpty) {
                                return 'Please enter your email id';
                              }
                              if (!isValidEmail(textValue)) {
                                return 'Please enter valid email id';
                              }
                              return null;
                            }else{
                              return 'Please enter your email id';
                            }
                          },
                        ),
                        const SizedBox(height: 16,),
                        CustomPasswordInputField(
                          controller: controller.passwordController,
                          labelText: 'Password',
                          isDense: true,
                          hintText: 'Enter your password',
                          obscureText: true,
                          suffixIcon: true,
                          validator: (textValue) {
                            if(textValue != null) {
                              textValue = textValue.trim();
                              if(textValue.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            }else{
                              return 'Please enter your password';
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Obx(()=>
                              Checkbox(
                                value: controller.rememberMe.value,
                                activeColor: AppColor.kAppPrimary,
                                checkColor: Colors.black,
                                onChanged: (bool? value) {
                                  setState(() {
                                    controller.rememberMe.value = value ?? false;
                                  });
                                },
                              ),
                            ),
                            const Text("Remember Me"),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Obx(()=> CustomFormButton(innerText: controller.isLoading.value ? 'Signing In...' : 'Sign In',
                            onPressed: controller.isLoading.value ? (){} : () => _handleLoginUser(context))),
                        const SizedBox(height: 16,),
                        CustomFormButton(innerText: 'Sign Up', onPressed: () {
                          // _handleLoginUser(controller.loginFormKey,context,controller);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const RegistrationPage()));
                        },),
                        const SizedBox(height: 16,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLoginUser(BuildContext context) {
    if (loginFormKey.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Logging in..')),
      // );

      controller.login();

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const IO()));

      // Get.offAndToNamed(AppRoutes.dashboard);
    }
  }
}
