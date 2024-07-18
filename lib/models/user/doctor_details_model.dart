// To parse this JSON data, do
//
//     final doctorDetailsModel = doctorDetailsModelFromJson(jsonString);

import 'dart:convert';

DoctorDetailsModel doctorDetailsModelFromJson(String str) => DoctorDetailsModel.fromJson(json.decode(str));

String doctorDetailsModelToJson(DoctorDetailsModel data) => json.encode(data.toJson());

class DoctorDetailsModel {
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
  final List<Schedule>? allSchedule;
  final List<TopReview>? topReviews;
  final List<String>? timeSlots;

  DoctorDetailsModel({
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
    this.allSchedule,
    this.topReviews,
    this.timeSlots,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) => DoctorDetailsModel(
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
    allSchedule: json["allSchedule"] == null ? [] : List<Schedule>.from(json["allSchedule"]!.map((x) => Schedule.fromJson(x))),
    topReviews: json["topReviews"] == null ? [] : List<TopReview>.from(json["topReviews"]!.map((x) => TopReview.fromJson(x))),
    timeSlots: json["timeSlots"] == null ? [] : List<String>.from(json["timeSlots"]!.map((x) => x)),
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
    "allSchedule": allSchedule == null ? [] : List<dynamic>.from(allSchedule!.map((x) => x.toJson())),
    "topReviews": topReviews == null ? [] : List<dynamic>.from(topReviews!.map((x) => x.toJson())),
    "timeSlots": timeSlots == null ? [] : List<dynamic>.from(timeSlots!.map((x) => x)),
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

class DoctorId {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
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

  DoctorId({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
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
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) => DoctorId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
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
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
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

class TopReview {
  final String? id;
  final String? comment;
  final int? rating;
  final String? doctorId;
  final PatientId? patientId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  TopReview({
    this.id,
    this.comment,
    this.rating,
    this.doctorId,
    this.patientId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TopReview.fromJson(Map<String, dynamic> json) => TopReview(
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
  final Image? image;

  PatientId({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
  });

  factory PatientId.fromJson(Map<String, dynamic> json) => PatientId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "image": image?.toJson(),
  };
}
