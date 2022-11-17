class QrCodeModel {
  int? createdAt;
  String? createdBy;
  String? isLocked;
  String? parkId;
  String? publicHashTag;
  bool? isActivated;
  String? customerName;
  String? customerEmail;
  int? age;
  String? role;
  String? teamName ;
  int? teamColor ;

  QrCodeModel(
      {this.createdAt,
        this.createdBy,
        this.isLocked,
        this.parkId,
        this.publicHashTag,
        this.isActivated,
        this.customerName,
        this.customerEmail,
        this.age,
        this.role,
        this.teamName,
        this.teamColor});

  QrCodeModel.fromJson(Map<dynamic, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    isLocked = json['isLocked'];
    parkId = json['parkId'];
    publicHashTag = json['publicHashTag'];
    isActivated = json['isActivated'];
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    age = json['age'];
    role = json['role'];
    teamName = json['teamName'];
    teamColor = json['teamColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['isLocked'] = this.isLocked;
    data['parkId'] = this.parkId;
    data['publicHashTag'] = this.publicHashTag;
    data['isActivated'] = this.isActivated;
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    data['age'] = this.age;
    data['role'] = this.role;
    data['teamName'] = this.teamName;
    data['teamColor'] = this.teamColor;
    return data;
  }
}