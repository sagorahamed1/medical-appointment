
class CetegoryModel {
  final String? id;
  final String? name;
  final Image? image;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  CetegoryModel({
    this.id,
    this.name,
    this.image,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CetegoryModel.fromJson(Map<String, dynamic> json) => CetegoryModel(
    id: json["_id"],
    name: json["name"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image?.toJson(),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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
