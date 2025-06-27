class UserEntity {
  final String uId;
  final String name;
  final String password;
  final String? phone;
  final String? email;
  final String image;
  final String userType;
  final String joiningDate;
  final String admin;
  final String? directManager;
  final String? areaManager;
  final String territory;
  final String? nationalId;
  final String? address;
  final String? basicSalary;
  final String? notes;
  final String employeeStatus;

  UserEntity({
    required this.uId,
    required this.name,
    required this.password,
    this.phone,
    this.email,
    required this.image,
    required this.userType,
    required this.joiningDate,
    required this.admin,
    this.directManager,
    this.areaManager,
    required this.territory,
    this.nationalId,
    this.address,
    this.basicSalary,
    this.notes,
    required this.employeeStatus,
  });


   UserEntity copyWith({
    String? uId,
    String? userType,
    String? name,
    String? password,
    String? phone,
    String? image,
    String? email,
    String? joiningDate,
    String? admin,
    String? directManager,
    String? areaManager,
    String? territory,
    String? nationalId,
    String? address,
    String? basicSalary,
    String? notes,
    String? employeeStatus,
  }) {
    return UserEntity(
      uId: uId ?? this.uId,
      userType: userType ?? this.userType,
      name: name ?? this.name,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      email: email ?? this.email,
      joiningDate: joiningDate ?? this.joiningDate,
      admin: admin ?? this.admin,
      directManager: directManager ?? this.directManager,
      areaManager: areaManager ?? this.areaManager,
      territory: territory ?? this.territory,
      nationalId: nationalId ?? this.nationalId,
      address: address ?? this.address,
      basicSalary: basicSalary ?? this.basicSalary,
      notes: notes ?? this.notes,
      employeeStatus: employeeStatus ?? this.employeeStatus,
    );
  }

}

//class UserEntity {
//   final String uId;
//   final String name;
//   final String image;
//   final String userType;
//   final String joiningDate;
//   final String directManager;
//   final String areaManager;
//   final String territory;
//   final String employeeStatus;

//   // بيانات اضافية للمندوب
//   final String? email;
//   final String? phone;
//   final String? nationalId;
//   final String? address;
//   final String? basicSalary;
//   final String? notes;

//   UserEntity({
//     required this.uId,
//     required this.name,
//     required this.phone,
//     required this.image,
//     required this.userType,
//     required this.joiningDate,
//     required this.directManager,
//     required this.areaManager,
//     required this.territory,
//     this.email,
//     this.nationalId,
//     this.address,
//     this.basicSalary,
//     this.notes,
//     required this.employeeStatus,
//   });
// }
