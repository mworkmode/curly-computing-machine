import 'package:crypto_app/View/customer_management_screen/controllers/customer_details_update_controller.dart';
import 'package:crypto_app/constants/text_form_field_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/custom_form_button.dart';
import '../../helper/functions.dart';
import '../../theme/app_colors.dart';

class CustomerDetailsUpdate extends StatelessWidget {
  CustomerDetailsUpdate({super.key});

  final CustomerDetailsUpdateController controller = Get.put(CustomerDetailsUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.kAppPrimary,
        title: Text(controller.userData.userName ?? '',style: const TextStyle(fontSize: 18,color: AppColor.black,fontWeight: FontWeight.w600),),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(()=>
              CircleAvatar(
                backgroundColor: controller.enableEdit.value ? AppColor.white : AppColor.kAppPrimary,
                child: IconButton(
                  onPressed: () {
                    controller.enableEdit.value = !controller.enableEdit.value;
                  },
                  icon: const Icon(Icons.edit, color: AppColor.black,)
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Form(
              child: Obx(()=>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'User Status',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Switch(
                          value: controller.isUserActive.value,
                          onChanged: controller.passwordController.text.toString().trim() == controller.code.value.toString().trim() ? null : (value) {
                            controller.isUserActive.value = !controller.isUserActive.value;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Full name',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Full name',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Full name',
                      controller: controller.userNameController,
                      // focusNode: signupVM.lastNameFocusNode.value,
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
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Enter Your Email',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'example@gmail.com',
                      controller: controller.emailController,
                      // focusNode: signupVM.emailFocusNode.value,
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
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Enter Your Password',
                      lebelFontColor: const Color(0xff1A1A1A),
                      obscure: controller.obscured.value,
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Enter Your Password',
                      controller: controller.passwordController,
                      // focusNode: signupVM.passwordFocusNode.value,
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
                            onTap: controller.toggleObscured,
                            child: Icon(
                              controller.obscured.value
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 24,
                            ),
                          )),
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Pan Card Number',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Pan Card Number',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Pan Card Number',
                      controller: controller.panNumberController,
                      // focusNode: signupVM.lastNameFocusNode.value,
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
                    const Text(
                      'Account Number',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Account Number',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Account Number',
                      controller: controller.accountNumberController,
                      // focusNode: signupVM.lastNameFocusNode.value,
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
                    const Text(
                      'IFSC Code',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'IFSC Code',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'IFSC Code',
                      controller: controller.ifscNumberController,
                      // focusNode: signupVM.lastNameFocusNode.value,
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
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Phone Number',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Phone Number',
                      controller: controller.mobileNumberController,
                      // focusNode: signupVM.lastNameFocusNode.value,
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
                    const SizedBox(height: 15,),
                    const Text(
                      'Account Fund',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Account Fund',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Account Fund',
                      controller: controller.accountFundValueController,
                      // focusNode: signupVM.lastNameFocusNode.value,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your account fund';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Total Value',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Total Value',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Total Value',
                      controller: controller.totalValueController,
                      // focusNode: signupVM.lastNameFocusNode.value,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your total value';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Total Gain',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Total Gain',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Total Gain',
                      controller: controller.todayGainController,
                      // focusNode: signupVM.lastNameFocusNode.value,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your total gain';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Total Loss',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Total Loss',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Total Loss',
                      controller: controller.todayLossController,
                      // focusNode: signupVM.lastNameFocusNode.value,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your total loss';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Total Gain',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormFieldLabel(
                      enabled: controller.enableEdit.value,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      lebelText: 'Total Gain & Loss',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Total Gain & Loss',
                      controller: controller.overallGainOrLossController,
                      // focusNode: signupVM.lastNameFocusNode.value,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your gain & loss';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30,),
                    Obx(()=> Align(
                      alignment: Alignment.center,
                      child: CustomFormButton(innerText: controller.isLoading.value ? 'Updating...' : 'Update',
                          onPressed: controller.isLoading.value ? (){} : () => controller.submitForm(context)),
                    )),
                    const SizedBox(height: 30,),

                  ],
                ),
              )
            ),
          ),
        )
      ),
    );
  }
}
