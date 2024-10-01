
class ChatUserModel {
  final String? id;
  final List<Participant>? participants;
  final AppointmentId? appointmentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final LastMessage? lastMessage;

  ChatUserModel({
    this.id,
    this.participants,
    this.appointmentId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastMessage,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) => ChatUserModel(
    id: json["_id"],
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    appointmentId: json["appointmentId"] == null ? null : AppointmentId.fromJson(json["appointmentId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "appointmentId": appointmentId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "lastMessage": lastMessage?.toJson(),
  };
}

class AppointmentId {
  final String? id;
  final String? transactionId;
  final String? patientId;
  final Package? package;
  final DateTime? date;
  final int? amount;
  final String? timeSlot;
  final PatientDetailsId? patientDetailsId;
  final String? doctorId;
  final String? status;
  final bool? isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  AppointmentId({
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

  factory AppointmentId.fromJson(Map<String, dynamic> json) => AppointmentId(
    id: json["_id"],
    transactionId: json["transactionId"],
    patientId: json["patientId"],
    package: json["package"] == null ? null : Package.fromJson(json["package"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    amount: json["amount"],
    timeSlot: json["timeSlot"],
    patientDetailsId: json["patientDetailsId"] == null ? null : PatientDetailsId.fromJson(json["patientDetailsId"]),
    doctorId: json["doctorId"],
    status: json["status"],
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "transactionId": transactionId,
    "patientId": patientId,
    "package": package?.toJson(),
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "timeSlot": timeSlot,
    "patientDetailsId": patientDetailsId?.toJson(),
    "doctorId": doctorId,
    "status": status,
    "isCompleted": isCompleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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

class LastMessage {
  final Content? content;
  final String? id;
  final String? chatId;
  final String? senderId;
  final String? receiverId;
  final FileClass? file;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  LastMessage({
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

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    content: json["content"] == null ? null : Content.fromJson(json["content"]),
    id: json["_id"],
    chatId: json["chatId"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "content": content?.toJson(),
    "_id": id,
    "chatId": chatId,
    "senderId": senderId,
    "receiverId": receiverId,
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

class Participant {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? rate;
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
  final String? oneTimeCode;
  final int? v;
  final String? address;
  final String? gender;
  final String? phone;
  final String? dateOfBirth;
  final String? rating;
  final int? reviewCount;
  final num? earningAmount;

  Participant({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.rate,
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
    this.v,
    this.address,
    this.gender,
    this.phone,
    this.dateOfBirth,
    this.rating,
    this.reviewCount,
    this.earningAmount,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    rate: json["rate"],
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
    v: json["__v"],
    address: json["address"],
    gender: json["gender"],
    phone: json["phone"],
    dateOfBirth: json["dateOfBirth"],
    rating: json["rating"],
    reviewCount: json["reviewCount"],
    earningAmount: json["earningAmount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "rate": rate,
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
    "__v": v,
    "address": address,
    "gender": gender,
    "phone": phone,
    "dateOfBirth": dateOfBirth,
    "rating": rating,
    "reviewCount": reviewCount,
    "earningAmount": earningAmount,
  };
}
