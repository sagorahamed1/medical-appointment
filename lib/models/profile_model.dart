

class ProfileModel {
  final String? rating;
  final int? reviewCount;
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
  final Image? image;
  final dynamic insurance;
  final bool? isInsurance;
  final String? role;
  final dynamic oneTimeCode;
  final int? v;
  final String? address;
  final String? gender;
  final String? phone;
  final String? dateOfBirth;

  ProfileModel({
    this.rating,
    this.reviewCount,
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
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    rating: json["rating"],
    reviewCount: json["reviewCount"],
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
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    insurance: json["insurance"],
    isInsurance: json["isInsurance"],
    role: json["role"],
    oneTimeCode: json["oneTimeCode"],
    v: json["__v"],
    address: json["address"],
    gender: json["gender"],
    phone: json["phone"],
    dateOfBirth: json["dateOfBirth"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "reviewCount": reviewCount,
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
