import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uId,
    required super.name,
    required super.image,
    required super.userType,
    required super.joiningDate,
    required super.directManager,
    required super.areaManager,
    required super.territory,
    required super.employeeStatus,

    super.email,
    super.phone,
    super.nationalId,
    super.address,
    super.basicSalary,
    super.notes,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      name: json['name'],
      image: json['image'],
      userType: json['userType'],
      joiningDate: json['joiningDate'],
      directManager: json['directManager'],
      areaManager: json['areaManager'],
      territory: json['territory'],
      employeeStatus: json['employmentStatus'],

      email: json['email'],
      phone: json['phone'],
      nationalId: json['nationalId'],
      address: json['address'],
      basicSalary: json['basicSalary'],
      notes: json['notes'],
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      uId: user.uId,
      name: user.name,
      phone: user.phone,
      image: user.image,
      userType: user.userType,
      email: user.email,
      joiningDate: user.joiningDate,
      directManager: user.directManager,
      areaManager: user.areaManager,
      territory: user.territory,
      nationalId: user.nationalId,
      address: user.address,
      basicSalary: user.basicSalary,
      notes: user.notes,
      employeeStatus: user.employeeStatus,
    );
  }

  toMap() {
    return {
      'uId': uId,
      'name': name,
      'phone': phone,
      'image': image,
      'userType': userType,
      'email': email,
      'joiningDate': joiningDate,
      'directManager': directManager,
      'areaManager': areaManager,
      'territory': territory,
      'nationalId': nationalId,
      'address': address,
      'basicSalary': basicSalary,
      'notes': notes,
      'employmentStatus': employeeStatus,
    };
  }
}
