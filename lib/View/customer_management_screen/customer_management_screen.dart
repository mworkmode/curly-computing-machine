import 'package:crypto_app/View/customer_management_screen/controllers/customer_listing_controller.dart';
import 'package:crypto_app/View/customer_management_screen/customer_details_update.dart';
import 'package:crypto_app/helper/functions.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants/text_form_field_label.dart';

class CustomerManagementScreen extends StatelessWidget {
  CustomerManagementScreen({super.key});

  final CustomerListingController controller = Get.put(CustomerListingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColor.kAppPrimary,
          title: const Text("Management",style: TextStyle(fontSize: 18,color: AppColor.black,fontWeight: FontWeight.w600),),
        ),
        body: Obx(()=>
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Dollar Price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormFieldLabel(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        lebelText: 'Dollar Price',
                        lebelFontColor: const Color(0xff1A1A1A),
                        borderRadius: BorderRadius.circular(10.0),
                        hint: 'Dollar Price',
                        controller: controller.dollarPriceController,
                        // focusNode: signupVM.lastNameFocusNode.value,
                        validating: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Dollar Price';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.updateDollar();
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        )),
                        backgroundColor: WidgetStateProperty.all(AppColor.kAppPrimary)
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black
                        ),
                      )
                    ),
                    const SizedBox(width: 10,),
                  ],
                ),
                const SizedBox(height: 15,),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const Divider(color: AppColor.black,thickness: 2,),
                      TextFormFieldLabel(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        lebelText: 'UPI ID',
                        lebelFontColor: const Color(0xff1A1A1A),
                        borderRadius: BorderRadius.circular(10.0),
                        hint: 'UPI ID',
                        controller: controller.upiTextController,
                        // focusNode: signupVM.lastNameFocusNode.value,
                        validating: (value) {
                          if (value!.isEmpty) {
                            return 'Enter UPI ID';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 5,),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            onPressed: () {
                              if(controller.formKey.currentState!.validate()){
                                controller.updateUpiData();
                              }
                            },
                            style: ButtonStyle(
                                shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                )),
                                backgroundColor: WidgetStateProperty.all(AppColor.kAppPrimary)
                            ),
                            child: const Text(
                              'Update Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.black
                              ),
                            )
                        ),
                      ),
                      const Divider(color: AppColor.black,thickness: 2,),
                    ],
                  )
                ),
                const SizedBox(height: 15,),
                ListView.separated(
                  itemCount: controller.userList.value.length,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10,);
                  },
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.grey.shade100,
                            onTap: () {
                              Get.to(()=>CustomerDetailsUpdate(),arguments: {
                                'user': controller.userList.value[index]
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.userTie,
                                    color: AppColor.gray,
                                    size: 28,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8, left: 25),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              controller.userList.value[index].userName ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Bal : ${formatAmount(controller.userList.value[index].accountFundValue ?? 0)}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        backgroundColor: Colors.white,
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 20,),
                                            const Icon(Icons.delete_forever,size: 120,),
                                            const SizedBox(height: 10,),
                                            const Text(
                                              'Are you sure you want to delete?',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              // mainAxisSize: MainAxisSize.min,
                                              children: [
                                                _buttonWidget('Cancel',() {
            
                                                },AppColor.lightGrey),
                                                _buttonWidget('Delete',() {
            
                                                },null),
                                              ],
                                            ),
                                            const SizedBox(height: 20,),
                                          ],
                                        )
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: AppColor.gray,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonWidget(String text, Function()? onTap,Color? buttonColor){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        gradient: buttonColor != null ? LinearGradient(
            colors: [
              buttonColor,
              buttonColor,
            ]
        ) : const LinearGradient(
            colors: [
              AppColor.kAppSecondary,
              AppColor.kAppPrimary,
            ]
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
            child: Text(text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetRow(BuildContext context, IconData icon, String text, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              icon,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
