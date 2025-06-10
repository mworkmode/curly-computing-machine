
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewChartPage extends StatefulWidget {
  @override
  State<TradingViewChartPage> createState() => _TradingViewChartPageState();
}

class _TradingViewChartPageState extends State<TradingViewChartPage> {
  late final WebViewController _controller;
  RxBool isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xff1c1c1c))..enableZoom(false)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          isLoading.value = true;
        },
        onPageFinished: (url) {
          isLoading.value = false;
        },
      ))
      ..loadFlutterAsset('assets/tradingview.html');
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
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
    return Obx( ()=> PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(!didPop){
          _goBack(context);
        }
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: isLoading.value ? const Center(child: CircularProgressIndicator(color: Colors.white,)) : WebViewWidget(controller: _controller,),
        ),
    ),
    );
  }
}