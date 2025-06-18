class SoapNoteModel {
  final String? id;
  final User? userId;
  final User? patientId;
  final User? doctorId;
  final String? subjective;
  final String? objective;
  final String? assessment;
  final String? plan;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SoapNoteModel({
    this.id,
    this.userId,
    this.patientId,
    this.doctorId,
    this.subjective,
    this.objective,
    this.assessment,
    this.plan,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SoapNoteModel.fromJson(Map<String, dynamic> json) {
    return SoapNoteModel(
      id: json['_id'],
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      patientId: json['patientId'] != null ? User.fromJson(json['patientId']) : null,
      doctorId: json['doctorId'] != null ? User.fromJson(json['doctorId']) : null,
      subjective: json['subjective'],
      objective: json['objective'],
      assessment: json['assessment'],
      plan: json['plan'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': userId?.toJson(),
    'patientId': patientId?.toJson(),
    'doctorId': doctorId?.toJson(),
    'subjective': subjective,
    'objective': objective,
    'assessment': assessment,
    'plan': plan,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final ImageInfo? image;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'] != null ? ImageInfo.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'image': image?.toJson(),
  };
}

class ImageInfo {
  final String? publicFileURL;
  final String? path;

  ImageInfo({
    this.publicFileURL,
    this.path,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      publicFileURL: json['publicFileURL'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() => {
    'publicFileURL': publicFileURL,
    'path': path,
  };
}
