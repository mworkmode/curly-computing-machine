import 'package:crypto_app/View/customer_management_screen/customer_management_screen.dart';
import 'package:crypto_app/View/login/login_page.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../home/nav_bar_controller.dart';
class CustomColors {
  // static const Color primaryColor = Color(0xFF7D5A50);
  static const Color primaryColor = Color(0xffFBC700);
  // static const Color secondaryColor = Color(0xFFFDF6F0);
  // static const Color secondaryColor = Color(0xFFFDF6F0);
  static const Color secondaryColor = Color.fromARGB(255, 255, 255, 255);
  static const Color primaryText = Color(0xFF000000);
}
class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

  final NavBarController controller = Get.put(NavBarController());
   static const darkBg = Color(0xFF121212);
   static const cardColor = Color(0xFF1E1E1E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: darkBg,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
                colors: [
                  AppColor.kAppSecondary,
                  AppColor.kAppPrimary,
                  // AppColor.kAppPrimary.withOpacity(0.5),
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
              onTap: () {
                Get.offAll(()=>const LoginPage());
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                child: Text('Logout',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(controller.userData!.value.userPassword.toString().toLowerCase() == controller.code.value.toString().toLowerCase())...[
                  DrawerButton(
                    onPressed: () {
                      Get.to(() => CustomerManagementScreen());
                    },
                  ),
                ],
                const SizedBox(height: 20,),
                Container(
                  decoration: const BoxDecoration(),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 160,
                      height: 160,
                      // clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.grayText,width: 2),
                      ),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/icons/hfgkf.png',
                        ),
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 12),
                //     child: Text(
                //       controller.userData?.value.userName?.capitalizeFirst ?? '',
                //       textAlign: TextAlign.start,
                //       style: const TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: SizedBox(
                      height: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.gray.withValues(alpha: 0),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.user,
                                color: CustomColors.primaryColor,
                                size: 28,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8, left: 25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Name',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          controller.userData?.value.userName?.capitalizeFirst ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: SizedBox(
                      height: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.mail_rounded,
                                color: CustomColors.primaryColor,
                                size: 28,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8, left: 25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          controller.userData?.value.userEmail ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: SizedBox(
                    height: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.perm_contact_cal_rounded,
                              color: CustomColors.primaryColor,
                              size: 28,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8, left: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Contact',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        controller.userData?.value.mobileNumber ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: SizedBox(
                    height: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.buildingColumns,
                              color: CustomColors.primaryColor,
                              size: 28,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8, left: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Account',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        controller.userData?.value.userAccountNumber ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: SizedBox(
                      height: 70,
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.idCard,
                                color: CustomColors.primaryColor,
                                size: 28,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8, left: 25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Aadhar',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          controller.userData?.value.userAadharNumber ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                //   child: SizedBox(
                //       height: 70,
                //       child: Container(
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(12),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey.withOpacity(0.5),
                //               spreadRadius: 2,
                //               blurRadius: 5,
                //               offset: const Offset(0, 2),
                //             ),
                //           ],
                //         ),
                //         child: const Padding(
                //           padding: EdgeInsets.only(left: 15),
                //           child: Row(
                //             children: [
                //               Icon(
                //                 Icons.discord_rounded,
                //                 color: CustomColors.primaryColor,
                //                 size: 28,
                //               ),
                //               Expanded(
                //                 child: Padding(
                //                   padding: EdgeInsets.only(top: 8, left: 25),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         'Discord',
                //                         style: TextStyle(
                //                           fontSize: 15,
                //                           fontWeight: FontWeight.normal,
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding: EdgeInsets.only(top: 5),
                //                         child: Text(
                //                           '@uexr',
                //                           style: TextStyle(
                //                             fontSize: 16,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )),
                // ),
              ],
            ),
          ),
        ));
  }
}