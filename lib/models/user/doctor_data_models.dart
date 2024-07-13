

class DoctorDataModel {
  String? id;
  String? specialist;
  String? experience;
  String? clinicAddress;
  String? about;
  DoctorId? doctorId;
  String? clinicPrice;
  String? onlineConsultationPrice;
  String? emergencyPrice;
  List<Schedule>? schedule;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<String>? timeSlots;

  DoctorDataModel({
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

  DoctorDataModel copyWith({
    String? id,
    String? specialist,
    String? experience,
    String? clinicAddress,
    String? about,
    DoctorId? doctorId,
    String? clinicPrice,
    String? onlineConsultationPrice,
    String? emergencyPrice,
    List<Schedule>? schedule,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    List<String>? timeSlots,
  }) =>
      DoctorDataModel(
        id: id ?? this.id,
        specialist: specialist ?? this.specialist,
        experience: experience ?? this.experience,
        clinicAddress: clinicAddress ?? this.clinicAddress,
        about: about ?? this.about,
        doctorId: doctorId ?? this.doctorId,
        clinicPrice: clinicPrice ?? this.clinicPrice,
        onlineConsultationPrice: onlineConsultationPrice ?? this.onlineConsultationPrice,
        emergencyPrice: emergencyPrice ?? this.emergencyPrice,
        schedule: schedule ?? this.schedule,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        timeSlots: timeSlots ?? this.timeSlots,
      );

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) => DoctorDataModel(
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
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  bool? privacyPolicyAccepted;
  bool? isAdmin;
  bool? isProfileCompleted;
  bool? isEmergency;
  bool? isVerified;
  bool? isDeleted;
  bool? isBlocked;
  Image? image;
  String? role;
  dynamic oneTimeCode;
  int? v;

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

  DoctorId copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    bool? privacyPolicyAccepted,
    bool? isAdmin,
    bool? isProfileCompleted,
    bool? isEmergency,
    bool? isVerified,
    bool? isDeleted,
    bool? isBlocked,
    Image? image,
    String? role,
    dynamic oneTimeCode,
    int? v,
  }) =>
      DoctorId(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        privacyPolicyAccepted: privacyPolicyAccepted ?? this.privacyPolicyAccepted,
        isAdmin: isAdmin ?? this.isAdmin,
        isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
        isEmergency: isEmergency ?? this.isEmergency,
        isVerified: isVerified ?? this.isVerified,
        isDeleted: isDeleted ?? this.isDeleted,
        isBlocked: isBlocked ?? this.isBlocked,
        image: image ?? this.image,
        role: role ?? this.role,
        oneTimeCode: oneTimeCode ?? this.oneTimeCode,
        v: v ?? this.v,
      );

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
  String? publicFileUrl;
  String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  Image copyWith({
    String? publicFileUrl,
    String? path,
  }) =>
      Image(
        publicFileUrl: publicFileUrl ?? this.publicFileUrl,
        path: path ?? this.path,
      );

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
  String? day;
  String? startTime;
  String? endTime;

  Schedule({
    this.day,
    this.startTime,
    this.endTime,
  });

  Schedule copyWith({
    String? day,
    String? startTime,
    String? endTime,
  }) =>
      Schedule(
        day: day ?? this.day,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );

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
