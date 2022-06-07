class QrCodeModel {
  int? createdAt;
  String? createdBy;
  String? isLocked;
  String? parkId;
  List<String>? players;
  String? publicHashTag;
  int? remainingCredit;
  bool? isActivated;
  String? customerName;
  String? customerEmail;
  int? age;
  String? role;

  QrCodeModel(
      {this.createdAt,
        this.createdBy,
        this.isLocked,
        this.parkId,
        this.players,
        this.publicHashTag,
        this.remainingCredit,
        this.isActivated,
        this.customerName,
        this.customerEmail,
        this.age,
        this.role});

  QrCodeModel.fromJson(Map<dynamic, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    isLocked = json['isLocked'];
    parkId = json['parkId'];
    players = json['players'].cast<String>();
    publicHashTag = json['publicHashTag'];
    remainingCredit = json['remainingCredit'];
    isActivated = json['isActivated'];
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    age = json['age'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['isLocked'] = this.isLocked;
    data['parkId'] = this.parkId;
    data['players'] = this.players;
    data['publicHashTag'] = this.publicHashTag;
    data['remainingCredit'] = this.remainingCredit;
    data['isActivated'] = this.isActivated;
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    data['age'] = this.age;
    data['role'] = this.role;
    return data;
  }
}