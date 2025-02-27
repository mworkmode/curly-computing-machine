import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:upi_india/upi_india.dart';

class AddFundController extends GetxController{
  var arguments = Get.arguments;
  Future<UpiResponse>? transaction;
  final UpiIndia _upiIndia = UpiIndia();
  RxList<UpiApp>? apps = <UpiApp>[].obs;
  DatabaseReference ref = FirebaseDatabase.instance.ref('Demo_data_app_custom');
  RxString upiIDFinal = ''.obs;
  RxString upiNoteFinal = ''.obs;

  @override
  void onInit() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      apps?.value = value;
    }).catchError((e) {
      apps?.value = [];
    });
    print('data $arguments');
    if(arguments != null){
      upiIDFinal.value = arguments['data1'];
      upiNoteFinal.value = arguments['data2'];
      print('data1 $upiIDFinal');
      print(upiNoteFinal);
    }

    super.onInit();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "6364008330@ybl",
      receiverName: 'Md Azharuddin',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  String upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }


}