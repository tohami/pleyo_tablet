class QrCodeModel {
  late String publicHashTag;
  late int remainingCredit;
  late String parkId;
  late int createdAt;
  late String createdBy;
  late String? customerEmail ;
  late List<String> transActionsList;

  QrCodeModel(
      { required this.publicHashTag,
        required this.remainingCredit,
        required this.parkId,
        required this.createdAt,
        required this.createdBy,
        required this.customerEmail,
        required this.transActionsList});

  QrCodeModel.fromJson(Map<dynamic, dynamic> json) {
    publicHashTag = json['publicHashTag'];
    remainingCredit = json['remainingCredit'];
    parkId = json['parkId'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    customerEmail = json['customerEmail'];
    transActionsList = json['transActionsList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publicHashTag'] = publicHashTag;
    data['remainingCredit'] = remainingCredit;
    data['parkId'] = parkId;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['customerEmail'] = customerEmail;
    data['transActionsList'] = transActionsList;
    return data;
  }
}