import 'package:crypto_app/View/payment/add_fund_screen.dart';
import 'package:crypto_app/helper/functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../theme/app_colors.dart';
import '../home/nav_bar_controller.dart';
import '../withdraw/withdraw_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> with TickerProviderStateMixin {

  NavBarController controller = Get.put(NavBarController());
  late final WebViewController _webController;
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  static const darkBg = Color(0xFF121212);
  static const cardColor = Color(0xFF222323);
  RxDouble _webViewHeight = 0.0.obs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xff1c1c1c))..enableZoom(false)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          // isLoading.value = true;
        },
        onPageFinished: (url) async {
          // isLoading.value = false;
          final heightStr = await _webController.runJavaScriptReturningResult(
              "document.documentElement.scrollHeight;"
          );
          _webViewHeight.value = double.tryParse(heightStr.toString()) ?? 100.00;
        },
      ))
      ..loadFlutterAsset('assets/mini_chart.html');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _webController.canGoBack()) {
      _webController.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Do you want to exit'),
            actions: <Widget>[
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              FilledButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ));
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(!didPop){
          _goBack(context);
        }
      },
      child: Scaffold(
        backgroundColor: darkBg,
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Portfolio",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Expanded(flex: 7, child: _buildPortfolioTable()),
                Expanded(flex: 7, child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(()=> _labelWithValue("Total Value", formatAmount(controller.userData?.value.totalValue ?? 0))),
                      Row(
                        children: [
                          Obx(()=> _gainLossCard("Today's Gain", formatAmount(controller.userData?.value.todayGain ?? 0), Colors.green)),
                          Obx(()=> _gainLossCard("Today's Loss", formatAmount(controller.userData?.value.todayLoss ?? 0), Colors.red)),
                        ],
                      ),
                      Obx(()=> _labelWithValue("Overall Gain/Loss", formatAmount(controller.userData?.value.overallGainOrLoss ?? 0))),
                      const SizedBox(height: 5,),
                      Obx(()=>
                          _webViewHeight.value > 0 ? ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: _webViewHeight.value,minHeight: 90),
                          child: AbsorbPointer(absorbing: true, child: WebViewWidget(controller: _webController)),
                        ) : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioTable() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor.withValues(alpha: 0.5),
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
          ],
          rows: List.generate(controller.userData!.value.portfolioList!.length, (index) => _getRow(index)),
        ),
      ),
    );
  }

  List<dynamic> dataList = [
    {'currency': 'Dollar', 'flag': '🇺🇸', 'lot': '15000', 'investment': '50000'},
    {'currency': 'Rupee', 'flag': '🇮🇳', 'lot': '50', 'investment': '2000000'},
    {'currency': 'Yen', 'flag': '🇯🇵', 'lot': '5', 'investment': '8500'},
  ];

  DataRow _getRow(int index, [Color? color]) {
    assert(index >= 0);
    if (index >= controller.userData!.value.portfolioList!.length) throw 'index > _desserts.length';
    final item = controller.userData!.value.portfolioList![index];
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
              Expanded(child: Text(" ${item.currency}", style: const TextStyle(color: Colors.white))),
            ],
          )
        ),
        DataCell(Text("${item.lotSize}", style: const TextStyle(color: Colors.white))),
        DataCell(Text(formatAmount(double.parse(item.investment ?? '')), style: const TextStyle(color: Colors.white))),
      ],
    );
  }

  Widget _labelWithValue(String label, String value) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 5000),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.gray.withValues(alpha: 0.1))
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(label, style: const TextStyle(color: Colors.white70)),
          ),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.white),textAlign: TextAlign.end,)),
        ],
      ),
    );
  }

  Widget _gainLossCard(String title, String value, Color color) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: cardColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.gray.withValues(alpha: 0.1))
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  color == Colors.green ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: color,
                  size: 30,
                ),
                Expanded(child: Text(value, style: TextStyle(color: color, fontSize: 20),textAlign: TextAlign.left,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
