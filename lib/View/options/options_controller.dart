import 'dart:developer';

import 'package:crypto_app/Model/coinModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OptionsController extends GetxController{

  RxBool isRefreshing = true.obs;
  RxList<CoinModel>? coinMarket = <CoinModel>[].obs;
  dynamic coinMarketList;

  @override
  void onInit() {
    getCoinMarket();
    super.onInit();
  }

  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    isRefreshing.value = true;
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
      isRefreshing.value = false;

    if (response.statusCode == 200) {
      var x = response.body;
      log('DataRes : ${x.toString()}');
      coinMarketList = coinModelFromJson(x);
      coinMarket?.value = coinMarketList;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
    return null;
  }

}