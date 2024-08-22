// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

List<ChatModel> chatModelFromJson(String str) => List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModel {
  final Content? content;
  final String? id;
  final String? chatId;
  final ErId? senderId;
  final ErId? receiverId;
  final FileClass? file;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ChatModel({
    this.content,
    this.id,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    content: json["content"] == null ? null : Content.fromJson(json["content"]),
    id: json["_id"],
    chatId: json["chatId"],
    senderId: json["senderId"] == null ? null : ErId.fromJson(json["senderId"]),
    receiverId: json["receiverId"] == null ? null : ErId.fromJson(json["receiverId"]),
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "content": content?.toJson(),
    "_id": id,
    "chatId": chatId,
    "senderId": senderId?.toJson(),
    "receiverId": receiverId?.toJson(),
    "file": file?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Content {
  final String? messageType;
  final String? message;

  Content({
    this.messageType,
    this.message,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    messageType: json["messageType"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "message": message,
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

class ErId {
  final String? id;
  final String? firstName;
  final String? lastName;
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
  final FileClass? image;
  final dynamic insurance;
  final bool? isInsurance;
  final String? role;
  final dynamic oneTimeCode;
  final int? earningAmount;
  final int? v;
  final String? address;
  final String? dateOfBirth;
  final Phone? phone;
  final String? gender;

  ErId({
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
    this.dateOfBirth,
    this.phone,
    this.gender,
  });

  factory ErId.fromJson(Map<String, dynamic> json) => ErId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: emailValues.map[json["email"]]!,
    rating: json["rating"],
    reviewCount: json["reviewCount"],
    privacyPolicyAccepted: json["privacyPolicyAccepted"],
    isAdmin: json["isAdmin"],
    isProfileCompleted: json["isProfileCompleted"],
    isEmergency: json["isEmergency"],
    isVerified: json["isVerified"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    image: json["image"],
    insurance: json["insurance"],
    isInsurance: json["isInsurance"],
    role: json["role"],
    oneTimeCode: json["oneTimeCode"],
    earningAmount: json["earningAmount"],
    v: json["__v"],
    address: json["address"],
    dateOfBirth: json["dateOfBirth"],
    phone: phoneValues.map[json["phone"]]!,
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
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
    "role": role,
    "oneTimeCode": oneTimeCode,
    "earningAmount": earningAmount,
    "__v": v,
    "address": address,
    "dateOfBirth": dateOfBirth,
    "phone": phoneValues.reverse[phone],
    "gender": gender,
  };
}


enum Email {
  DOCTOR2_GMAIL_COM,
  PATIENT_GMAIL_COM
}

final emailValues = EnumValues({
  "doctor2@gmail.com": Email.DOCTOR2_GMAIL_COM,
  "patient@gmail.com": Email.PATIENT_GMAIL_COM
});


enum Phone {
  EMPTY,
  THE_01533887945
}

final phoneValues = EnumValues({
  "": Phone.EMPTY,
  "01533887945": Phone.THE_01533887945
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
