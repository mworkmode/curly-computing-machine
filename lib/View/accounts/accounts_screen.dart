import 'package:crypto_app/helper/functions.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/nav_bar_controller.dart';
import '../payment/add_fund_screen.dart';
import '../withdraw/withdraw_screen.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> with TickerProviderStateMixin {

  NavBarController controller = Get.put(NavBarController());
  static const darkBg = Color(0xFF121212);
  static const cardColor = Color(0xFF1E1E1E);
  static const orange = Color(0xFFFF9800);
  static const green = Color(0xFF2E7D32);
  static const red = Color(0xFFC62828);

  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: darkBg,
          ),
          child: FadeTransition(
            opacity: _fadeIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'Account Details',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColor.white,
                        ),
                      ),
                      SizedBox(width: 8,),
                      Icon(Icons.remove_red_eye_outlined,color: Color(0xffc7c5c5),size: 20,)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Obx(()=> _buildInfoRow(Icons.account_balance_wallet, "Balance", '₹ ${formatAmount(controller.userData?.value.accountFundValue ?? 0)}', Colors.amber)),
                      const SizedBox(height: 20),
                      Obx(()=> _buildInfoRow(Icons.trending_up, "Limit", (controller.userData?.value.limitValue ?? 0).toInt().toString(), Colors.yellow)),
                      const SizedBox(height: 20),
                      Obx(()=> _buildInfoRow(Icons.bar_chart, "Position", (controller.userData?.value.positionValue ?? 0).toInt().toString(), Colors.yellowAccent)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.to(()=> AddFundScreen(
                            data1: controller.upiID.value,
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        icon: const Icon(Icons.add,color: AppColor.black,size: 20,),
                        label: const Text("Add Funds",style: TextStyle(color: AppColor.black, fontSize: 16,
                          fontWeight: FontWeight.normal,),),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.to(()=> WithdrawScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cardColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        icon: const Icon(Icons.arrow_forward,color: AppColor.white,size: 20,),
                        label: const Text("Withdraw",style: TextStyle(color: AppColor.white, fontSize: 16,
                          fontWeight: FontWeight.normal,),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildStatCard("Total Profit", "₹${formatAmount(controller.userData?.value.totalProfit ?? 0)}", Icons.arrow_upward, green,upSide: true),
                const SizedBox(height: 20),
                _buildStatCard("Total Loss", "₹${formatAmount(controller.userData?.value.totalLoss ?? 0)}", Icons.arrow_downward, red),


                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Expanded(
                //           child: addFundButton(onPressed: () {
                //             Get.to(()=> AddFundScreen(
                //               data1: controller.upiID.value,
                //             ));
                //           }),
                //         ),
                //         const SizedBox(width: 15,),
                //         Expanded(
                //           child: withdrawFundButton(onPressed: () {
                //             Get.to(()=> WithdrawScreen());
                //           },),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // const Spacer(),
                // Material(
                //   child: ListTile(
                //     // shape: Border.all(color: AppColor.gray),
                //       tileColor: const Color(0xff313030),
                //       contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                //       dense: true,
                //       leading: const Text(
                //         'Balance',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xfffaf7f7),
                //             decorationStyle: TextDecorationStyle.dashed
                //         ),
                //       ),
                //       trailing: Obx(()=>
                //           Text(
                //             '₹ ${formatAmount(controller.userData?.value.accountFundValue ?? 0)}',
                //             textAlign: TextAlign.start,
                //             style: const TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: Color(0xfffaf7f7),
                //                 decorationStyle: TextDecorationStyle.dashed
                //             ),
                //           ),
                //       )
                //   ),
                // ),
                // const SizedBox(height: 10,),
                // Material(
                //   child: ListTile(
                //       // shape: Border.all(color: AppColor.gray),
                //       tileColor: const Color(0xff525050),
                //       contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                //       dense: true,
                //       leading: const Text(
                //         'Limit',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xfffaf7f7),
                //             decorationStyle: TextDecorationStyle.dashed
                //         ),
                //       ),
                //       trailing: Obx(()=>
                //           Text(
                //             formatAmount(controller.userData?.value.overallGainOrLoss ?? 0),
                //             textAlign: TextAlign.start,
                //             style: const TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: Color(0xfffaf7f7),
                //                 decorationStyle: TextDecorationStyle.dashed
                //             ),
                //           ),
                //       )
                //   ),
                // ),
                // const SizedBox(height: 10,),
                // Material(
                //   child: ListTile(
                //       // shape: Border.all(color: AppColor.gray),
                //       tileColor: const Color(0xff313030),
                //       contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                //       dense: true,
                //       leading: const Text(
                //         'Position',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xfffaf7f7),
                //             decorationStyle: TextDecorationStyle.dashed
                //         ),
                //       ),
                //       trailing: Obx(()=>
                //           Text(
                //             formatAmount(controller.userData?.value.overallGainOrLoss ?? 0),
                //             textAlign: TextAlign.start,
                //             style: const TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: Color(0xfffaf7f7),
                //                 decorationStyle: TextDecorationStyle.dashed
                //             ),
                //           ),
                //       )
                //   ),
                // ),
                // const SizedBox(height: 10,),
                // Material(
                //   child: ListTile(
                //       // shape: Border.all(color: AppColor.gray),
                //       tileColor: const Color(0xff525050),
                //       contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                //       dense: true,
                //       leading: const Text(
                //         'Profit',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xfffaf7f7),
                //             decorationStyle: TextDecorationStyle.dashed
                //         ),
                //       ),
                //       trailing: Obx(()=>
                //           Text(
                //             formatAmount(controller.userData?.value.overallGainOrLoss ?? 0),
                //             textAlign: TextAlign.start,
                //             style: const TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: Color(0xfffaf7f7),
                //                 decorationStyle: TextDecorationStyle.dashed
                //             ),
                //           ),
                //       )
                //   ),
                // ),
                // const SizedBox(height: 10,),
                // Material(
                //   child: ListTile(
                //       // shape: Border.all(color: AppColor.gray),
                //       tileColor: const Color(0xff313030),
                //       dense: true,
                //       contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                //       leading: const Text(
                //         'Loss',
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xfffaf7f7),
                //             decorationStyle: TextDecorationStyle.dashed
                //         ),
                //       ),
                //       trailing: Obx(()=>
                //           Text(
                //             formatAmount(controller.userData?.value.overallGainOrLoss ?? 0),
                //             textAlign: TextAlign.start,
                //             style: const TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: Color(0xfffaf7f7),
                //                 decorationStyle: TextDecorationStyle.dashed
                //             ),
                //           ),
                //       )
                //   ),
                // ),
                // const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 12),
        Text(
          "$label:",
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
        ),
        const Spacer(),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String amount, IconData icon, Color color, {bool upSide = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          RotationTransition(
            turns: AlwaysStoppedAnimation(upSide ? (45/360) : (315/360)),
            child: CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.3),
              child: Icon(icon, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                ),
                Text(
                  amount,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget addFundButton({required void Function()? onPressed}){
  //   return ElevatedButton(
  //     onPressed: onPressed,
  //     style: ButtonStyle(
  //         padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
  //         shape: WidgetStateProperty.all(const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10))
  //         )),
  //         backgroundColor: WidgetStateProperty.all(const Color(0xfffc8805))
  //     ),
  //     child: Text('Add Funds', style: Theme.of(context)
  //         .textTheme
  //         .bodyMedium
  //         ?.copyWith(
  //         fontSize: 18,
  //         fontWeight: FontWeight.bold,
  //         color: AppColor.white),
  //     ),
  //   );
  // }
  //
  // Widget withdrawFundButton({required void Function()? onPressed}){
  //   return OutlinedButton(
  //     onPressed: onPressed,
  //     style: ButtonStyle(
  //       padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
  //       shape: WidgetStateProperty.all(const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(10))
  //       )),
  //       // backgroundColor: MaterialStateProperty.all(const Color(0xffFBC700))
  //     ),
  //     child: Text('Withdraw', style: Theme.of(context)
  //         .textTheme
  //         .bodyMedium
  //         ?.copyWith(
  //         fontSize: 18,
  //         fontWeight: FontWeight.bold,
  //         color: AppColor.white),
  //     ),
  //   );
  // }

}
