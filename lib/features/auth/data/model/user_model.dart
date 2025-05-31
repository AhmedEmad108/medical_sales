import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uId,
    required super.name,
    required super.phone,
    required super.image,
    required super.userType, // Add role to the constructor
  });

  // factory UserModel.fromFirebaseUser(User user) {
  //   return UserModel(
  //     uId: user.uid,
  //     name: user.displayName ?? '',
  //     phone: user.phoneNumber ?? '',
  //     image: user.photoURL ?? '',
  //     role: user.role,
  //   );
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      userType: json['userType'] ?? '', // Add role from JSON
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      uId: user.uId,
      name: user.name,
      phone: user.phone,
      image: user.image,
      userType: user.userType, // Add role from entity
    );
  }

  toMap() {
    return {
      'uId': uId,
      'name': name,
      'phone': phone,
      'image': image,
      'userType': userType, // Add role to the map
    };
  }
}
