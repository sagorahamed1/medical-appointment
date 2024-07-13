

class UserAppointMentModel {
  String? id;
  String? transactionId;
  Id? patientId;
  double? price;
  DateTime? date;
  String? timeSlot;
  PatientDetailsId? patientDetailsId;
  Id? doctorId;
  String? status;
  bool? isCompleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserAppointMentModel({
    this.id,
    this.transactionId,
    this.patientId,
    this.price,
    this.date,
    this.timeSlot,
    this.patientDetailsId,
    this.doctorId,
    this.status,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  UserAppointMentModel copyWith({
    String? id,
    String? transactionId,
    Id? patientId,
    double? price,
    DateTime? date,
    String? timeSlot,
    PatientDetailsId? patientDetailsId,
    Id? doctorId,
    String? status,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      UserAppointMentModel(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        patientId: patientId ?? this.patientId,
        price: price ?? this.price,
        date: date ?? this.date,
        timeSlot: timeSlot ?? this.timeSlot,
        patientDetailsId: patientDetailsId ?? this.patientDetailsId,
        doctorId: doctorId ?? this.doctorId,
        status: status ?? this.status,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory UserAppointMentModel.fromJson(Map<String, dynamic> json) => UserAppointMentModel(
    id: json["_id"],
    transactionId: json["transactionId"],
    patientId: json["patientId"] == null ? null : Id.fromJson(json["patientId"]),
    price: json["price"]?.toDouble(),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
    "price": price,
    "date": date?.toIso8601String(),
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
  String? rate;
  Image? insurance;
  bool? isInsurance;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  bool? privacyPolicyAccepted;
  bool? isAdmin;
  bool? isProfileCompleted;
  bool? isEmergency;
  bool? isVerified;
  bool? isDeleted;
  bool? isBlocked;
  Image? image;
  String? role;
  String? oneTimeCode;
  int? v;
  String? address;
  String? gender;
  String? phone;

  Id({
    this.rate,
    this.insurance,
    this.isInsurance,
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
    this.address,
    this.gender,
    this.phone,
  });

  Id copyWith({
    String? rate,
    Image? insurance,
    bool? isInsurance,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? privacyPolicyAccepted,
    bool? isAdmin,
    bool? isProfileCompleted,
    bool? isEmergency,
    bool? isVerified,
    bool? isDeleted,
    bool? isBlocked,
    Image? image,
    String? role,
    String? oneTimeCode,
    int? v,
    String? address,
    String? gender,
    String? phone,
  }) =>
      Id(
        rate: rate ?? this.rate,
        insurance: insurance ?? this.insurance,
        isInsurance: isInsurance ?? this.isInsurance,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
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
        address: address ?? this.address,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone,
      );

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    rate: json["rate"],
    insurance: json["insurance"] == null ? null : Image.fromJson(json["insurance"]),
    isInsurance: json["isInsurance"],
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
    address: json["address"],
    gender: json["gender"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "insurance": insurance?.toJson(),
    "isInsurance": isInsurance,
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
    "address": address,
    "gender": gender,
    "phone": phone,
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

class PatientDetailsId {
  String? id;
  String? patientId;
  String? fullName;
  String? gender;
  String? age;
  String? description;
  String? doctorId;
  int? v;

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

  PatientDetailsId copyWith({
    String? id,
    String? patientId,
    String? fullName,
    String? gender,
    String? age,
    String? description,
    String? doctorId,
    int? v,
  }) =>
      PatientDetailsId(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        fullName: fullName ?? this.fullName,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        description: description ?? this.description,
        doctorId: doctorId ?? this.doctorId,
        v: v ?? this.v,
      );

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
