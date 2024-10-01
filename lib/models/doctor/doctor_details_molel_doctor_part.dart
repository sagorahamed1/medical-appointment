
class DoctorDetailsModelDoctorPart {
  final String? id;
  final String? specialist;
  final String? experience;
  final String? clinicAddress;
  final String? about;
  final DoctorId? doctorId;
  final String? clinicPrice;
  final String? onlineConsultationPrice;
  final String? emergencyPrice;
  final List<Schedule>? schedule;
  final List<Package>? packages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  DoctorDetailsModelDoctorPart({
    this.id,
    this.specialist,
    this.experience,
    this.clinicAddress,
    this.about,
    this.doctorId,
    this.clinicPrice,
    this.onlineConsultationPrice,
    this.emergencyPrice,
    this.schedule,
    this.packages,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DoctorDetailsModelDoctorPart.fromJson(Map<String, dynamic> json) => DoctorDetailsModelDoctorPart(
    id: json["_id"],
    specialist: json["specialist"],
    experience: json["experience"],
    clinicAddress: json["clinicAddress"],
    about: json["about"],
    doctorId: json["doctorId"] == null ? null : DoctorId.fromJson(json["doctorId"]),
    clinicPrice: json["clinicPrice"],
    onlineConsultationPrice: json["onlineConsultationPrice"],
    emergencyPrice: json["emergencyPrice"],
    schedule: json["schedule"] == null ? [] : List<Schedule>.from(json["schedule"]!.map((x) => Schedule.fromJson(x))),
    packages: json["packages"] == null ? [] : List<Package>.from(json["packages"]!.map((x) => Package.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "specialist": specialist,
    "experience": experience,
    "clinicAddress": clinicAddress,
    "about": about,
    "doctorId": doctorId?.toJson(),
    "clinicPrice": clinicPrice,
    "onlineConsultationPrice": onlineConsultationPrice,
    "emergencyPrice": emergencyPrice,
    "schedule": schedule == null ? [] : List<dynamic>.from(schedule!.map((x) => x.toJson())),
    "packages": packages == null ? [] : List<dynamic>.from(packages!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class DoctorId {
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
  final double? earningAmount;
  final int? v;
  final String? address;
  final String? gender;
  final String? phone;

  DoctorId({
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

  factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
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

class Schedule {
  final String? day;
  final String? startTime;
  final String? endTime;

  Schedule({
    this.day,
    this.startTime,
    this.endTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    day: json["day"],
    startTime: json["startTime"],
    endTime: json["endTime"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "startTime": startTime,
    "endTime": endTime,
  };
}
