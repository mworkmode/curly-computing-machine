import 'package:crypto_app/View/Components/item.dart';
import 'package:crypto_app/View/Components/item2.dart';
import 'package:crypto_app/View/home/nav_bar_controller.dart';
import 'package:crypto_app/View/options/options_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final OptionsController optionsController = Get.put(OptionsController(),permanent: true);
  NavBarController controller = Get.put(NavBarController());

  @override
  void initState() {
    // getCoinMarket();
    super.initState();
  }

  final ScrollController _horizontalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 253, 225, 112),
                Color(0xffFBC700),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: myHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Main portfolio',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Text(
                    'Top 10 coins',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    'Experimental',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=>
                    Text(
                      '\$${controller.dollarPrice.value}',
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(myWidth * 0.02),
                    height: myHeight * 0.05,
                    width: myWidth * 0.1,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5)),
                    child: Image.asset(
                      'assets/icons/5.1.png',
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: myHeight * 0.01,
            ),
            Container(
              height: myHeight * 0.73,
              width: myWidth,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey.shade300,
                        spreadRadius: 3,
                        offset: const Offset(0, 3))
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: myHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: myWidth * 0.09),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Assets',
                          style: TextStyle(fontSize: 20),
                        ),
                        // Icon(Icons.add)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                    width: myWidth * 0.01,
                  ),
                  Obx(()=> SizedBox(
                      height: myHeight * 0.36,
                      child: optionsController.isRefreshing.value == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xffFBC700),
                              ),
                            )
                          : optionsController.coinMarket == null || optionsController.coinMarket!.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.all(myHeight * 0.01),
                                  child: const Center(
                                    child: Text(
                                      'Something went wrong, please try again later.',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                )
                              : Scrollbar(
                                controller: _horizontalController,
                                child: ListView.builder(
                                    itemCount: 10,
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Item(
                                        item: optionsController.coinMarket![index],
                                      );
                                    },
                                  ),
                              ),
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: myWidth * 0.04),
                    child: const Row(
                      children: [
                        Text(
                          'Recommend to Buy',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Expanded(
                    child: Obx(()=> Padding(
                        padding: EdgeInsets.only(left: myWidth * 0.01),
                        child: optionsController.isRefreshing.value == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                            : optionsController.coinMarket == null || optionsController.coinMarket!.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.all(myHeight * 0.01),
                                    child: const Center(
                                      child: Text(
                                        'Attention you cannot send multiple requests per second, please wait and try again later.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: optionsController.coinMarket!.length,
                                    itemBuilder: (context, index) {
                                      return Item2(
                                        item: optionsController.coinMarket![index],
                                      );
                                    },
                                  ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // bool isRefreshing = true;
  //
  // List? coinMarket = [];
  // var coinMarketList;
  // Future<List<CoinModel>?> getCoinMarket() async {
  //   const url =
  //       'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
  //
  //   setState(() {
  //     isRefreshing = true;
  //   });
  //   var response = await http.get(Uri.parse(url), headers: {
  //     "Content-Type": "application/json",
  //     "Accept": "application/json",
  //   });
  //   setState(() {
  //     isRefreshing = false;
  //   });
  //   if (response.statusCode == 200) {
  //     var x = response.body;
  //     coinMarketList = coinModelFromJson(x);
  //     setState(() {
  //       coinMarket = coinMarketList;
  //     });
  //   } else {
  //     if (kDebugMode) {
  //       print(response.statusCode);
  //     }
  //   }
  //   return null;
  // }
}
