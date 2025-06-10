import 'package:crypto_app/View/customer_management_screen/controllers/customer_portfolio_update_controller.dart';
import 'package:crypto_app/constants/text_form_field_label.dart';
import 'package:crypto_app/helper/functions.dart';
import 'package:crypto_app/theme/app_colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerPortfolioUpdate extends StatefulWidget {
  const CustomerPortfolioUpdate({super.key});

  @override
  State<CustomerPortfolioUpdate> createState() => _CustomerPortfolioUpdateState();

  static const cardColor = Color(0xFF222323);
}

class _CustomerPortfolioUpdateState extends State<CustomerPortfolioUpdate> {
  final CustomerPortfolioUpdateController controller = Get.put(CustomerPortfolioUpdateController());

  RxList<dynamic> tradeList = [
    {'currency': 'Dollar', 'flag': '🇺🇸', 'lot': '15000', 'investment': '50000'},
    {'currency': 'Rupee', 'flag': '🇮🇳', 'lot': '50', 'investment': '2000000'},
    {'currency': 'Yen', 'flag': '🇯🇵', 'lot': '5', 'investment': '8500'},
  ].obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.kAppPrimary,
          title: Text('${controller.userData.userName} details',style: const TextStyle(fontSize: 18,color: AppColor.black,fontWeight: FontWeight.w600),),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.45,
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                    decoration: BoxDecoration(
                      // color: Colors.black12,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(45)
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15,),
                          const Text(
                            'Currency name',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormFieldLabel(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            lebelText: 'Currency name',
                            lebelFontColor: const Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(10.0),
                            hint: 'Currency name',
                            controller: controller.currencyNameController,
                            // focusNode: signupVM.lastNameFocusNode.value,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Enter currency';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 15,),
                          const Text(
                            'Lot Size',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormFieldLabel(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            lebelText: 'Lot Size',
                            lebelFontColor: const Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(10.0),
                            hint: 'Lot Size',
                            controller: controller.lotSizeController,
                            // focusNode: signupVM.lastNameFocusNode.value,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Enter lot size';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 15,),
                          const Text(
                            'Bulk Investment',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextFormFieldLabel(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            lebelText: 'Bulk Investment',
                            lebelFontColor: const Color(0xff1A1A1A),
                            borderRadius: BorderRadius.circular(10.0),
                            hint: 'Bulk Investment',
                            controller: controller.bulkInvestmentController,
                            // focusNode: signupVM.lastNameFocusNode.value,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Enter bulk investment';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 25,),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Get.to(()=> AddFundScreen(
                                //   data1: controller.upiID.value,
                                // ));
                                if (controller.formKey.currentState!.validate()) {
                                  controller.onAddButtonClicked();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF1BB0B),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 10),
                                elevation: 5
                              ),
                              // icon: const Icon(Icons.add,color: AppColor.black,size: 20,),
                              label: const Text("Add Trade",style: TextStyle(color: AppColor.black, fontSize: 16,
                                fontWeight: FontWeight.bold,),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: _buildPortfolioTable(context)
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }

  Widget _buildPortfolioTable(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 0),
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: CustomerPortfolioUpdate.cardColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.gray.withValues(alpha: 0.1))
      ),
      alignment: Alignment.center,
      child: Obx(()=>
        DataTable2(
          border: TableBorder.symmetric(outside: BorderSide(color: AppColor.gray.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(15)),
          dividerThickness: 0.3,
          headingRowColor: WidgetStateProperty.all(Colors.transparent),
          columns: const [
            DataColumn2(
              label: Text('Currency',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 14),),
              size: ColumnSize.M,
              tooltip: 'Currency',
            ),
            DataColumn2(
                label: Text('Lot Size',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 14),),
                size: ColumnSize.M,
                tooltip: 'Lot Size'
            ),
            DataColumn2(
                label: Text('Bulk Investment',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 14),),
                size: ColumnSize.L,
                tooltip: 'Bulk Investment'
            ),
            DataColumn2(label: Text('Actions',style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 14),),
                size: ColumnSize.S,
                tooltip: 'Actions'
            ),
          ],
          rows: List.generate(controller.portfolioList.value.length, (index) => _getRow(index,context)),
        ),
      ),
    );
  }

  DataRow _getRow(int index, BuildContext context, [Color? color]) {
    assert(index >= 0);
    if (index >= controller.portfolioList.length) throw 'index > _desserts.length';
    final item = controller.portfolioList[index];
    return DataRow2.byIndex(
      index: index,
      color: color != null ? WidgetStateProperty.all(color) : null,
      specificRowHeight: 80,
      cells: [
        DataCell(
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.currency_exchange,color: Colors.amber,size: 16,),
                Expanded(child: Text(" ${item.currency ?? ''}", style: const TextStyle(color: Colors.white))),
              ],
            )
        ),
        DataCell(Text(item.lotSize ?? '', style: const TextStyle(color: Colors.white))),
        DataCell(Text(formatAmount(double.parse(item.investment ?? '')), style: const TextStyle(color: Colors.white))),
        DataCell(
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              Get.bottomSheet(
                  TapRegion(
                    onTapOutside: (event) => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(60.0)),
                        border: const Border(top: BorderSide(color: Colors.black12)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(1, 1),
                            blurRadius: 5,
                            spreadRadius: 0.5,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-1, -1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ColoredBox(
                              color: Colors.grey[300]!,
                              child: const SizedBox(width: 40, height: 5),
                            ),
                          ),
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
                            children: [
                              _buttonWidget('Cancel',() {
                                Get.back();
                              },AppColor.lightGrey),
                              _buttonWidget('Delete',() {
                                controller.deletePortfolioItem(item);
                                Get.back();
                              },null),
                            ],
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  )
              );
            },
          ),
        ),
      ],
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
            color: Colors.grey.withValues(alpha: 0.5),
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
}
