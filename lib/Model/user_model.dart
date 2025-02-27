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
    return data;
  }

}