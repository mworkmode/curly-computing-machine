import 'package:crypto_app/View/registration/registration_controller.dart';
import 'package:crypto_app/helper/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/custom_form_button.dart';
import '../../constants/text_form_field_label.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final RegistrationController controller = Get.put(RegistrationController());

  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    "Register Now",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormFieldLabel(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    lebelText: 'Full name',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Full name',
                    controller: controller.userNameController,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your full name';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldLabel(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    lebelText: 'Enter Your Email',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'example@gmail.com',
                    controller: controller.emailController,
                    validating: (value) {
                      if (value!.isEmpty || !isValidEmail(value)) {
                        return 'Enter valid email address';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny( RegExp(r'\s')),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldLabel(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    lebelText: 'Enter Your Password',
                    lebelFontColor: const Color(0xff1A1A1A),
                    obscure: _obscured,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Enter Your Password',
                    controller: controller.passwordController,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text,
                    validating: (value) {
                      if (value!.isEmpty || !isValidPassword(value)) {
                        return 'Password must contain 8+ characters with combination\nof uppercase,lowercase, numbers & symbols(@\$!%*?&)';
                      }
                      return null;
                    },
                    suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 24,
                          ),
                        )),
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldLabel(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    lebelText: 'Pan Card Number',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Pan Card Number',
                    controller: controller.panNumberController,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your pan card number';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldLabel(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    lebelText: 'Aadhar Number',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Aadhar Number',
                    controller: controller.aadharController,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter aadhar number';
                      }
                      if (value.length < 12) {
                        return 'Enter a valid aadhar number';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldLabel(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    lebelText: 'Account Number',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Account Number',
                    controller: controller.accountNumberController,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your account number';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldLabel(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    lebelText: 'IFSC Code',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'IFSC Code',
                    controller: controller.ifscNumberController,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your IFSC codd';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldLabel(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    lebelText: 'Phone Number',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Phone Number',
                    controller: controller.mobileNumberController,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your phone number';
                      }else if(value.length < 10){
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30,),
                  Obx(()=> CustomFormButton(innerText: controller.isLoading.value ? 'Signing Up...' : 'Sign Up',
                      onPressed: controller.isLoading.value ? (){} : () => controller.submitForm(context))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
