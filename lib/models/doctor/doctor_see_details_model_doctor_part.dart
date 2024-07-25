
class DoctorSeeDetailsModelDoctorPart {
  final String? id;
  final String? transactionId;
  final Id? patientId;
  final Package? package;
  final DateTime? date;
  final int? amount;
  final String? timeSlot;
  final PatientDetailsId? patientDetailsId;
  final Id? doctorId;
  final dynamic status;
  final bool? isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  DoctorSeeDetailsModelDoctorPart({
    this.id,
    this.transactionId,
    this.patientId,
    this.package,
    this.date,
    this.amount,
    this.timeSlot,
    this.patientDetailsId,
    this.doctorId,
    this.status,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DoctorSeeDetailsModelDoctorPart.fromJson(Map<String, dynamic> json) => DoctorSeeDetailsModelDoctorPart(
    id: json["_id"],
    transactionId: json["transactionId"],
    patientId: json["patientId"] == null ? null : Id.fromJson(json["patientId"]),
    package: json["package"] == null ? null : Package.fromJson(json["package"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    amount: json["amount"],
    timeSlot: json["timeSlot"],
    patientDetailsId: json["patientDetailsId"] == null ? null : PatientDetailsId.fromJson(json["patientDetailsId"]),
    doctorId: json["doctorId"] == null ? null : Id.fromJson(json["doctorId"]),
    status: json["status"],
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "transactionId": transactionId,
    "patientId": patientId?.toJson(),
    "package": package?.toJson(),
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "timeSlot": timeSlot,
    "patientDetailsId": patientDetailsId?.toJson(),
    "doctorId": doctorId?.toJson(),
    "status": status,
    "isCompleted": isCompleted,
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
  final bool? privacyPolicyAccepted;
  final bool? isAdmin;
  final bool? isProfileCompleted;
  final bool? isEmergency;
  final bool? isVerified;
  final bool? isDeleted;
  final bool? isBlocked;
  final Image? image;
  final String? role;
  final String? oneTimeCode;
  final int? v;
  final bool? isInsurance;
  final String? rating;
  final int? reviewCount;
  final Image? insurance;
  final String? address;
  final String? gender;
  final String? phone;
  final String? dateOfBirth;
  final int? earningAmount;
  final String? rate;

  Id({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.privacyPolicyAccepted,
    this.isAdmin,
    this.isProfileCompleted,
    this.isEmergency,
    this.isVerified,
    this.isDeleted,
    this.isBlocked,
    this.image,
    this.role,
    this.oneTimeCode,
    this.v,
    this.isInsurance,
    this.rating,
    this.reviewCount,
    this.insurance,
    this.address,
    this.gender,
    this.phone,
    this.dateOfBirth,
    this.earningAmount,
    this.rate,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    privacyPolicyAccepted: json["privacyPolicyAccepted"],
    isAdmin: json["isAdmin"],
    isProfileCompleted: json["isProfileCompleted"],
    isEmergency: json["isEmergency"],
    isVerified: json["isVerified"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    role: json["role"],
    oneTimeCode: json["oneTimeCode"],
    v: json["__v"],
    isInsurance: json["isInsurance"],
    rating: json["rating"],
    reviewCount: json["reviewCount"],
    insurance: json["insurance"] == null ? null : Image.fromJson(json["insurance"]),
    address: json["address"],
    gender: json["gender"],
    phone: json["phone"],
    dateOfBirth: json["dateOfBirth"],
    earningAmount: json["earningAmount"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "privacyPolicyAccepted": privacyPolicyAccepted,
    "isAdmin": isAdmin,
    "isProfileCompleted": isProfileCompleted,
    "isEmergency": isEmergency,
    "isVerified": isVerified,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "image": image?.toJson(),
    "role": role,
    "oneTimeCode": oneTimeCode,
    "__v": v,
    "isInsurance": isInsurance,
    "rating": rating,
    "reviewCount": reviewCount,
    "insurance": insurance?.toJson(),
    "address": address,
    "gender": gender,
    "phone": phone,
    "dateOfBirth": dateOfBirth,
    "earningAmount": earningAmount,
    "rate": rate,
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

class Package {
  final String? packageName;
  final String? packagePrice;

  Package({
    this.packageName,
    this.packagePrice,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    packageName: json["packageName"],
    packagePrice: json["packagePrice"],
  );

  Map<String, dynamic> toJson() => {
    "packageName": packageName,
    "packagePrice": packagePrice,
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
  final int? v;

  PatientDetailsId({
    this.id,
    this.patientId,
    this.fullName,
    this.gender,
    this.age,
    this.description,
    this.doctorId,
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
    "__v": v,
  };
}
