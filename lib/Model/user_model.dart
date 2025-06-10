import 'dart:developer';

import 'package:crypto_app/Model/portfolio_model.dart';

class UserModel {
  String? userId;
  String? userName;
  String? userEmail;
  bool? userStatus;
  String? userPassword;
  String? userPanNumber;
  String? userAccountNumber;
  String? userIFSCCode;
  double? dollarPrice;
  double? accountFundValue;
  double? totalValue;
  double? todayGain;
  double? todayLoss;
  double? overallGainOrLoss;
  String? mobileNumber;
  double? limitValue;
  double? positionValue;
  double? totalProfit;
  double? totalLoss;
  String? userAadharNumber;
  List<PortfolioModel>? portfolioList;

  UserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userStatus,
    this.userPassword,
    this.userPanNumber,
    this.userAccountNumber,
    this.userIFSCCode,
    this.dollarPrice,
    this.accountFundValue,
    this.totalValue,
    this.todayGain,
    this.todayLoss,
    this.overallGainOrLoss,
    this.mobileNumber,
    this.limitValue,
    this.positionValue,
    this.totalProfit,
    this.totalLoss,
    this.userAadharNumber,
    this.portfolioList,
  });

  UserModel.fromJson(Map<String,dynamic> json){
    userId = json['userId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userStatus = json['userStatus'];
    userPassword = json['userPassword'];
    userPanNumber = json['userPanNumber'];
    userAccountNumber = json['userAccountNumber'];
    userIFSCCode = json['userIFSCCode'];
    dollarPrice = (json['dollarPrice'] as num).toDouble();
    accountFundValue = (json['accountFundValue'] as num).toDouble();
    totalValue = (json['totalValue']as num).toDouble();
    todayGain = (json['todayGain']as num).toDouble();
    todayLoss = (json['todayLoss']as num).toDouble();
    overallGainOrLoss = (json['overallGainOrLoss']as num).toDouble();
    mobileNumber = json['mobileNumber'];
    limitValue = (json['limit_value']as num).toDouble();
    positionValue = (json['position_value']as num).toDouble();
    totalProfit = (json['total_profit']as num).toDouble();
    totalLoss = (json['total_loss']as num).toDouble();
    userAadharNumber = json['userAadharNumber'];
    List<PortfolioModel> parsedList = [];
    if (json['portfolio_list'] != null) {
      final data = json['portfolio_list'] as Map;
      parsedList = data.entries.map((e) {
        return PortfolioModel.fromJson(Map<String, dynamic>.from(e.value));
      }).toList();
    }
    portfolioList = parsedList;
  }

  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userStatus'] = userStatus;
    data['userPassword'] = userPassword;
    data['userPanNumber'] = userPanNumber;
    data['userAccountNumber'] = userAccountNumber;
    data['userIFSCCode'] = userIFSCCode;
    data['dollarPrice'] = dollarPrice;
    data['accountFundValue'] = accountFundValue;
    data['totalValue'] = totalValue;
    data['todayGain'] = todayGain;
    data['todayLoss'] = todayLoss;
    data['overallGainOrLoss'] = overallGainOrLoss;
    data['mobileNumber'] = mobileNumber;
    data['limit_value'] = limitValue;
    data['position_value'] = positionValue;
    data['total_profit'] = totalProfit;
    data['total_loss'] = totalLoss;
    data['userAadharNumber'] = userAadharNumber;
    if (portfolioList != null) {
      data['portfolio_list'] =  Map.fromEntries(
        portfolioList!.map((e) => MapEntry(e.id, e.toJson()))
      );
    }
    return data;
  }

}