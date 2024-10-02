

class GetReviewModel {
  final String? id;
  final String? comment;
  final int? rating;
  final String? doctorId;
  final PatientId? patientId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  GetReviewModel({
    this.id,
    this.comment,
    this.rating,
    this.doctorId,
    this.patientId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetReviewModel.fromJson(Map<String, dynamic> json) => GetReviewModel(
    id: json["_id"],
    comment: json["comment"],
    rating: json["rating"],
    doctorId: json["doctorId"],
    patientId: json["patientId"] == null ? null : PatientId.fromJson(json["patientId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "comment": comment,
    "rating": rating,
    "doctorId": doctorId,
    "patientId": patientId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class PatientId {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? rating;
  final int? reviewCount;
  final bool? privacyPolicyAccepted;
  final bool? isAdmin;
  final bool? isProfileCompleted;
  final bool? isEmergency;
  final bool? isVerified;
  final bool? isDeleted;
  final bool? isBlocked;
  final Image? image;
  final dynamic insurance;
  final bool? isInsurance;
  final String? role;
  final dynamic oneTimeCode;
  final int? earningAmount;
  final int? v;
  final String? address;
  final String? gender;
  final String? phone;
  final String? dateOfBirth;

  PatientId({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.rating,
    this.reviewCount,
    this.privacyPolicyAccepted,
    this.isAdmin,
    this.isProfileCompleted,
    this.isEmergency,
    this.isVerified,
    this.isDeleted,
    this.isBlocked,
    this.image,
    this.insurance,
    this.isInsurance,
    this.role,
    this.oneTimeCode,
    this.earningAmount,
    this.v,
    this.address,
    this.gender,
    this.phone,
    this.dateOfBirth,
  });

  factory PatientId.fromJson(Map<String, dynamic> json) => PatientId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    rating: json["rating"],
    reviewCount: json["reviewCount"],
    privacyPolicyAccepted: json["privacyPolicyAccepted"],
    isAdmin: json["isAdmin"],
    isProfileCompleted: json["isProfileCompleted"],
    isEmergency: json["isEmergency"],
    isVerified: json["isVerified"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    insurance: json["insurance"],
    isInsurance: json["isInsurance"],
    role: json["role"],
    oneTimeCode: json["oneTimeCode"],
    earningAmount: json["earningAmount"],
    v: json["__v"],
    address: json["address"],
    gender: json["gender"],
    phone: json["phone"],
    dateOfBirth: json["dateOfBirth"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "rating": rating,
    "reviewCount": reviewCount,
    "privacyPolicyAccepted": privacyPolicyAccepted,
    "isAdmin": isAdmin,
    "isProfileCompleted": isProfileCompleted,
    "isEmergency": isEmergency,
    "isVerified": isVerified,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "image": image?.toJson(),
    "insurance": insurance,
    "isInsurance": isInsurance,
    "role": role,
    "oneTimeCode": oneTimeCode,
    "earningAmount": earningAmount,
    "__v": v,
    "address": address,
    "gender": gender,
    "phone": phone,
    "dateOfBirth": dateOfBirth,
  };
}

class Image {
  final String? publicFileUrl;
  final String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicFileUrl: json["publicFileURL"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrl,
    "path": path,
  };
}
