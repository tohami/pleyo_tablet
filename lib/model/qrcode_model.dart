class QrCodeModel {
  String? publicHashTag;
  int? remainingCredit;
  List<String>? players;
  String? parkId;
  int? createdAt;
  String? createdBy;
  String? customerEmail ;
  List<String>? transActionsList;

  QrCodeModel(
      { required this.publicHashTag,
        required this.remainingCredit,
        required this.parkId,
        required this.createdAt,
        required this.createdBy,
        required this.players,
        required this.customerEmail,
        required this.transActionsList});

  QrCodeModel.fromJson(Map<dynamic, dynamic> json) {
    publicHashTag = json['publicHashTag'];
    remainingCredit = json['remainingCredit'];
    parkId = json['parkId'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    customerEmail = json['customerEmail'];
    if (json['transActionsList'] != null) {
      transActionsList = json['transActionsList'].cast<String>();
    }
    if (json['players'] != null) {
      players = json['players'].cast<String>();
    }
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
    data['players'] = players;
    return data;
  }
}