import 'package:crypto_app/Model/portfolio_model.dart';
import 'package:crypto_app/Model/user_model.dart';
import 'package:crypto_app/utils/app_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CustomerPortfolioUpdateController extends GetxController {
  var arguments = Get.arguments;
  UserModel userData = UserModel();
  RxBool isLoading = false.obs;
  Uuid uuid = const Uuid();

  final currencyNameController = TextEditingController();
  final lotSizeController = TextEditingController();
  final bulkInvestmentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxList<PortfolioModel> portfolioList = <PortfolioModel>[].obs;

  @override
  void onInit() {
    if(arguments != null) {
      userData = arguments['user'];
      portfolioList.value = userData.portfolioList ?? [];
    }
    super.onInit();
  }

  onAddButtonClicked(){
    PortfolioModel portfolioModel = PortfolioModel(
      id: uuid.v4(),
      userId: userData.userId,
      currency: currencyNameController.text,
      lotSize: lotSizeController.text,
      investment: bulkInvestmentController.text,
      createdAt: DateTime.now()
    );
    updatePortfolio(userData.userId!, portfolioModel);
  }

  updatePortfolio(String userId, PortfolioModel portfolioData) async{
    isLoading = true.obs;
    var newData = portfolioData.toJson();
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child('Demo_data_app').child(userId);
    userRef.child('portfolio_list/${portfolioData.id}').set(newData).then((value) {
      portfolioList.add(portfolioData);
      isLoading = false.obs;
      AppUtils.showSnackBar(title: 'Success', message: 'Portfolio updated');
      currencyNameController.clear();
      lotSizeController.clear();
      bulkInvestmentController.clear();
    }).onError((error, stackTrace) {
      isLoading = false.obs;
      AppUtils.showSnackBar(title: 'Failed', message: 'Something went wrong');
    });
  }

  Future<void> deletePortfolioItem(PortfolioModel portfolio) async {
    isLoading = true.obs;
    final itemRef = FirebaseDatabase.instance
        .ref("Demo_data_app/${portfolio.userId}/portfolio_list/${portfolio.id}");
    await itemRef.remove().then((value) {
      isLoading = false.obs;
      portfolioList.remove(portfolio);
      AppUtils.showSnackBar(title: 'Success', message: 'Portfolio updated');

    }).onError((error, stackTrace) {
      isLoading = false.obs;
      AppUtils.showSnackBar(title: 'Failed', message: 'Something went wrong');

    });
  }
}