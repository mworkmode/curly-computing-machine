import 'package:crypto_app/Model/user_model.dart';
import 'package:crypto_app/View/customer_management_screen/controllers/customer_details_update_controller.dart';
import 'package:crypto_app/View/customer_management_screen/customer_details_update.dart';
import 'package:crypto_app/View/customer_management_screen/customer_portfolio_update.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerProfileUpdate extends StatefulWidget {
  const CustomerProfileUpdate({super.key});

  @override
  State<CustomerProfileUpdate> createState() => _CustomerProfileUpdateState();
}

class _CustomerProfileUpdateState extends State<CustomerProfileUpdate> {
  final CustomerDetailsUpdateController controller = Get.put(CustomerDetailsUpdateController());

  UserModel userData = UserModel();

  @override
  void initState() {
    if(Get.arguments != null){
      userData = Get.arguments['user'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height / 3 - 24;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.kAppPrimary,
          title: Text('${controller.userData.userName} details',style: const TextStyle(fontSize: 18,color: AppColor.black,fontWeight: FontWeight.w600),),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(()=>CustomerPortfolioUpdate(),arguments: {
                      'user': userData
                    });
                  },
                  child: SizedBox(
                    height: cardHeight,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.indigo[400],
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.analytics, color: Colors.white, size: 50),
                            SizedBox(height: 12),
                            Text(
                              'Portfolio Analytics',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Go to portfolio analytics screen',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Card 2
                GestureDetector(
                  onTap: () {
                    Get.to(()=>CustomerDetailsUpdate(),arguments: {
                      'user': userData
                    });
                  },
                  child: SizedBox(
                    height: cardHeight,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.grey[800],
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.settings, color: Colors.white, size: 50),
                            SizedBox(height: 12),
                            Text(
                              'User Settings',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Go to user settings screen',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 56,
                ),
                // Card.filled(
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                //   elevation: 5,
                //
                //   child: Column(
                //     children: [
                //       FaIcon(FontAwesomeIcons.tradeFederation)
                //     ],
                //   ),
                // ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
