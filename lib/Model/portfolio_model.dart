class PortfolioModel {
  String? id;
  String? userId;
  String? currency;
  String? lotSize;
  String? investment;
  DateTime? createdAt;

  PortfolioModel({
    this.id,
    this.userId,
    this.currency,
    this.lotSize,
    this.investment,
    this.createdAt,
  });

  PortfolioModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    currency = json['currency'];
    lotSize = json['lot_size'];
    investment = json['investment'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(json['created_at']);
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String,dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['currency'] = currency;
    data['lot_size'] = lotSize;
    data['investment'] = investment;
    data['created_at'] = createdAt?.millisecondsSinceEpoch;
    return data;
  }
}