class QrCodeModel {
  String? publicHashTag;
  int? remainingCredit;
  List<String>? players;
  String? parkId;
  String? isLocked ;

  QrCodeModel(
      { required this.publicHashTag,
        required this.remainingCredit,
        required this.parkId,
        required this.players,
        required this.isLocked});

  QrCodeModel.fromJson(Map<dynamic, dynamic> json) {
    publicHashTag = json['publicHashTag'];
    remainingCredit = json['remainingCredit'];
    parkId = json['parkId'];
    isLocked = json['isLocked'];
    if (json['players'] != null) {
      players = json['players'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publicHashTag'] = publicHashTag;
    data['remainingCredit'] = remainingCredit;
    data['parkId'] = parkId;
    data['isLocked'] = isLocked;
    data['players'] = players;
    return data;
  }
}