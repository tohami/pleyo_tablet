class QrCodeModel {
  String? publicHashTag;
  int? remainingCredit;
  String? isLocked;
  String? parkId;
  bool? isActivated;
  String? customerName;

  QrCodeModel(
      {
        this.isLocked,
        this.parkId,
        this.publicHashTag,
        this.isActivated,
        this.customerName,
        this.remainingCredit,
      });

  QrCodeModel.fromJson(Map<dynamic, dynamic> json) {
    isLocked = json['isLocked'];
    parkId = json['parkId'];
    remainingCredit = json['remainingCredit'];
    publicHashTag = json['publicHashTag'];
    isActivated = json['isActivated'];
    customerName = json['customerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remainingCredit'] = remainingCredit;
    data['isLocked'] = this.isLocked;
    data['parkId'] = this.parkId;
    data['publicHashTag'] = this.publicHashTag;
    data['isActivated'] = this.isActivated;
    data['customerName'] = this.customerName;
    return data;
  }
}