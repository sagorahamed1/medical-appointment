

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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
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
    this.createdAt,
    this.updatedAt,
    this.v,
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "timeSlots": timeSlots == null ? [] : List<dynamic>.from(timeSlots!.map((x) => x)),
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
  final dynamic oneTimeCode;
  final int? v;

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
