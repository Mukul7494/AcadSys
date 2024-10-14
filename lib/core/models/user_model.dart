import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String role;
  final String gender;
  final bool isEmailVerified;
  final DateTime createdAt;
  final String? name;
  final String? photoUrl;
  final String? phoneNumber;
  final DateTime lastLoginAt;
  final bool active;

  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    required this.gender,
    required this.isEmailVerified,
    required this.createdAt,
    this.name,
    this.photoUrl,
    this.phoneNumber,
    required this.lastLoginAt,
    required this.active,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      gender: data['gender'] ?? '',
      isEmailVerified: data['isEmailVerified'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      name: data['name'] as String?,
      photoUrl: data['photoUrl'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      lastLoginAt:
          (data['lastLoginAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      active: data['active'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
      'gender': gender,
      'isEmailVerified': isEmailVerified,
      'createdAt': Timestamp.fromDate(createdAt),
      'name': name,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'lastLoginAt': Timestamp.fromDate(lastLoginAt),
      'active': active,
    };
  }
}
