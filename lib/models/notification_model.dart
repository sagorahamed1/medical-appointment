// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  final String? id;
  final String? message;
  final Role? role;
  final RecipientId? recipientId;
  final bool? read;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationModel({
    this.id,
    this.message,
    this.role,
    this.recipientId,
    this.read,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["_id"],
    message: json["message"],
    role: roleValues.map[json["role"]],
    recipientId: json["recipientId"] == null ? null : RecipientId.fromJson(json["recipientId"]),
    read: json["read"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "role": roleValues.reverse[role],
    "recipientId": recipientId?.toJson(),
    "read": read,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class RecipientId {
  final Id? id;
  final FirstName? firstName;
  final LastName? lastName;
  final Email? email;
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
  final Role? role;
  final dynamic oneTimeCode;
  final double? earningAmount;
  final int? v;
  final Address? address;
  final Gender? gender;
  final String? phone;

  RecipientId({
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

  factory RecipientId.fromJson(Map<String, dynamic> json) => RecipientId(
    id: idValues.map[json["_id"]],
    firstName: firstNameValues.map[json["firstName"]],
    lastName: lastNameValues.map[json["lastName"]],
    email: emailValues.map[json["email"]],
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
    role: roleValues.map[json["role"]],
    oneTimeCode: json["oneTimeCode"],
    earningAmount: json["earningAmount"].toDouble(),
    v: json["__v"],
    address: addressValues.map[json["address"]],
    gender: genderValues.map[json["gender"]],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "firstName": firstNameValues.reverse[firstName],
    "lastName": lastNameValues.reverse[lastName],
    "email": emailValues.reverse[email],
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
    "role": roleValues.reverse[role],
    "oneTimeCode": oneTimeCode,
    "earningAmount": earningAmount,
    "__v": v,
    "address": addressValues.reverse[address],
    "gender": genderValues.reverse[gender],
    "phone": phone,
  };
}

enum Address {
  DHAKA
}

final addressValues = EnumValues({
  "Dhaka": Address.DHAKA
});

enum Email {
  DOCTOR_GMAIL_COM
}

final emailValues = EnumValues({
  "doctor@gmail.com": Email.DOCTOR_GMAIL_COM
});

enum FirstName {
  MR_DOCTOR
}

final firstNameValues = EnumValues({
  "MR.Doctor": FirstName.MR_DOCTOR
});

enum Gender {
  MAIL
}

final genderValues = EnumValues({
  "Mail": Gender.MAIL
});

enum Id {
  THE_66_B334_B8_D4_D39_E4697199_DA7
}

final idValues = EnumValues({
  "66b334b8d4d39e4697199da7": Id.THE_66_B334_B8_D4_D39_E4697199_DA7
});

class Image {
  final PublicFileUrl? publicFileUrl;
  final Path? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicFileUrl: publicFileUrlValues.map[json["publicFileURL"]],
    path: pathValues.map[json["path"]],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrlValues.reverse[publicFileUrl],
    "path": pathValues.reverse[path],
  };
}

enum Path {
  PUBLIC_IMAGES_USERS_66_B334_B8_D4_D39_E4697199_DA7_USER_PNG
}

final pathValues = EnumValues({
  "public/images/users/66b334b8d4d39e4697199da7/user.png": Path.PUBLIC_IMAGES_USERS_66_B334_B8_D4_D39_E4697199_DA7_USER_PNG
});

enum PublicFileUrl {
  IMAGES_USERS_66_B334_B8_D4_D39_E4697199_DA7_USER_PNG
}

final publicFileUrlValues = EnumValues({
  "images/users/66b334b8d4d39e4697199da7/user.png": PublicFileUrl.IMAGES_USERS_66_B334_B8_D4_D39_E4697199_DA7_USER_PNG
});

enum LastName {
  ISLAM
}

final lastNameValues = EnumValues({
  "Islam": LastName.ISLAM
});

enum Role {
  ADMIN,
  DOCTOR
}

final roleValues = EnumValues({
  "admin": Role.ADMIN,
  "doctor": Role.DOCTOR
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
