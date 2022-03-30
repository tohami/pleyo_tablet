
class TransactionModel {
  late String qrCodeId;
  late bool isTrail;
  late int paymentValue;
  late int createdAt;
  late String createdBy;
  late String paymentCurrency;
  late int pointsAdded;

  TransactionModel(
      { required this.isTrail,
        required this.qrCodeId,
        required this.paymentValue,
        required this.createdAt,
        required this.createdBy,
        required this.paymentCurrency,
        required this.pointsAdded});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    qrCodeId = json['qrCodeId'];
    isTrail = json['isTrail'];
    paymentValue = json['paymentValue'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    paymentCurrency = json['paymentCurrency'];
    pointsAdded = json['pointsAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qrCodeId'] = qrCodeId;
    data['isTrail'] = isTrail;
    data['paymentValue'] = paymentValue;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['paymentCurrency'] = paymentCurrency;
    data['pointsAdded'] = pointsAdded;
    return data;
  }
}