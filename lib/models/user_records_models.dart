

class UserRecordsModel {
  final String? id;
  final Id? patientId;
  final FileClass? file;
  final Id? doctorId;
  final PatientDetailsId? patientDetailsId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserRecordsModel({
    this.id,
    this.patientId,
    this.file,
    this.doctorId,
    this.patientDetailsId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserRecordsModel.fromJson(Map<String, dynamic> json) => UserRecordsModel(
    id: json["_id"],
    patientId: json["patientId"] == null ? null : Id.fromJson(json["patientId"]),
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
    doctorId: json["doctorId"] == null ? null : Id.fromJson(json["doctorId"]),
    patientDetailsId: json["patientDetailsId"] == null ? null : PatientDetailsId.fromJson(json["patientDetailsId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "patientId": patientId?.toJson(),
    "file": file?.toJson(),
    "doctorId": doctorId?.toJson(),
    "patientDetailsId": patientDetailsId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Id {
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
  final FileClass? image;
  final dynamic insurance;
  final bool? isInsurance;
  final String? role;
  final dynamic oneTimeCode;
  final int? earningAmount;
  final int? v;
  final String? address;
  final String? gender;
  final String? phone;

  Id({
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
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
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
    image: json["image"] == null ? null : FileClass.fromJson(json["image"]),
    insurance: json["insurance"],
    isInsurance: json["isInsurance"],
    role: json["role"],
    oneTimeCode: json["oneTimeCode"],
    earningAmount: json["earningAmount"],
    v: json["__v"],
    address: json["address"],
    gender: json["gender"],
    phone: json["phone"],
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
  };
}

class FileClass {
  final String? publicFileUrl;
  final String? path;

  FileClass({
    this.publicFileUrl,
    this.path,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    publicFileUrl: json["publicFileURL"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrl,
    "path": path,
  };
}

class PatientDetailsId {
  final String? id;
  final String? patientId;
  final String? fullName;
  final String? gender;
  final String? age;
  final String? description;
  final String? doctorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PatientDetailsId({
    this.id,
    this.patientId,
    this.fullName,
    this.gender,
    this.age,
    this.description,
    this.doctorId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PatientDetailsId.fromJson(Map<String, dynamic> json) => PatientDetailsId(
    id: json["_id"],
    patientId: json["patientId"],
    fullName: json["fullName"],
    gender: json["gender"],
    age: json["age"],
    description: json["description"],
    doctorId: json["doctorId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "patientId": patientId,
    "fullName": fullName,
    "gender": gender,
    "age": age,
    "description": description,
    "doctorId": doctorId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
