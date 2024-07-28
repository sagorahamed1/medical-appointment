
class WithdrawListModel {
  final String? id;
  final String? doctorId;
  final String? bankName;
  final String? accountNumber;
  final String? accountType;
  final int? withdrawAmount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  WithdrawListModel({
    this.id,
    this.doctorId,
    this.bankName,
    this.accountNumber,
    this.accountType,
    this.withdrawAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory WithdrawListModel.fromJson(Map<String, dynamic> json) => WithdrawListModel(
    id: json["_id"],
    doctorId: json["doctorId"],
    bankName: json["bankName"],
    accountNumber: json["accountNumber"],
    accountType: json["accountType"],
    withdrawAmount: json["withdrawAmount"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "doctorId": doctorId,
    "bankName": bankName,
    "accountNumber": accountNumber,
    "accountType": accountType,
    "withdrawAmount": withdrawAmount,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
