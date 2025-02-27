import 'package:crypto_app/View/payment/add_fund_screen.dart';
import 'package:crypto_app/helper/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../utils/app_utils.dart';
import '../home/nav_bar_controller.dart';
import '../withdraw/withdraw_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {

  NavBarController controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    // double heightVal = MediaQuery.of(context).size.height;
    // double widthVal = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          // color: const Color(0xff4f4e4e),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.kAppPrimary.withOpacity(0.5),
                AppColor.kAppPrimary,
                AppColor.kAppPrimary.withOpacity(0.5),
              ]
            )
          ),
          child: Column(
            children: [
              // const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Color(0xff363636),
                  // borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Account Value',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffc7c5c5),
                            decorationStyle: TextDecorationStyle.dashed
                          ),
                        ),
                        SizedBox(width: 8,),
                        Icon(Icons.remove_red_eye_outlined,color: Color(0xffc7c5c5),size: 20,)
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Obx(()=> Text(
                        '₹ ${formatAmount(controller.userData?.value.accountFundValue ?? 0)}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                            decorationStyle: TextDecorationStyle.dashed
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: addFundButton(onPressed: () {
                            Get.to(()=> AddFundScreen(
                              data1: controller.upiID.value,
                            ));
                          }),
                        ),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: withdrawFundButton(onPressed: () {
                            Get.to(()=> WithdrawScreen());
                          },),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 0),
                    alignment: Alignment.bottomLeft,
                    color: const Color(0xff706e6e),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          Material(
                            child: ListTile(
                              tileColor: const Color(0xff313030),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                              leading: const Text(
                                'Total Value',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfffaf7f7),
                                    decorationStyle: TextDecorationStyle.dashed
                                ),
                              ),
                              trailing: Obx(()=>Text(
                                  formatAmount(controller.userData?.value.accountFundValue ?? 0),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfffaf7f7),
                                      decorationStyle: TextDecorationStyle.dashed
                                  ),
                                ),
                              )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Material(
                            child: ListTile(
                                tileColor: const Color(0xff525050),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                leading: const Text(
                                  'Today\'s gain',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfffaf7f7),
                                      decorationStyle: TextDecorationStyle.dashed
                                  ),
                                ),
                                trailing: Obx(()=>
                                  Text(
                                    formatAmount(controller.userData?.value.todayGain ?? 0),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfffaf7f7),
                                        decorationStyle: TextDecorationStyle.dashed
                                    ),
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Material(
                            child: ListTile(
                                tileColor: const Color(0xff313030),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                leading: const Text(
                                  'Today\'s loss',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfffaf7f7),
                                      decorationStyle: TextDecorationStyle.dashed
                                  ),
                                ),
                                trailing: Obx(()=>
                                  Text(
                                    formatAmount(controller.userData?.value.todayLoss ?? 0),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfffaf7f7),
                                        decorationStyle: TextDecorationStyle.dashed
                                    ),
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Material(
                            child: ListTile(
                                tileColor: const Color(0xff525050),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                leading: const Text(
                                  'Overall gain/loss',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfffaf7f7),
                                      decorationStyle: TextDecorationStyle.dashed
                                  ),
                                ),
                                trailing: Obx(()=>
                                  Text(
                                    formatAmount(controller.userData?.value.overallGainOrLoss ?? 0),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfffaf7f7),
                                        decorationStyle: TextDecorationStyle.dashed
                                    ),
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget addFundButton({required void Function()? onPressed}){
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        )),
        backgroundColor: WidgetStateProperty.all(const Color(0xfffc8805))
      ),
      child: Text('Add Funds', style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.white),
      ),
    );
  }

  Widget withdrawFundButton({required void Function()? onPressed}){
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      )),
          // backgroundColor: MaterialStateProperty.all(const Color(0xffFBC700))
      ),
      child: Text('Withdraw', style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.white),
      ),
    );
  }
}
