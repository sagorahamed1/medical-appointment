import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserModel {
  final String? firstName;
  final String? lastName;
  final Timestamp? createdAt;
  final String? email;
  final String? role;

  FirebaseUserModel({
    this.firstName,
    this.lastName,
    this.createdAt,
    this.email,
    this.role,
  });

  factory FirebaseUserModel.fromJson(Map<String, dynamic> json) {
    return FirebaseUserModel(
      createdAt: json['createdAt'] ?? '', // You were using 'role' here by mistake
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
