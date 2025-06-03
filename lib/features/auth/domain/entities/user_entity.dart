class UserEntity {
  final String uId;
  final String name;
  final String image;
  final String userType;
  final String joiningDate;
  final String directManager;
  final String areaManager;
  final String territory;
  final String employmentStatus;

  // بيانات اضافية للمندوب
  final String? email;
  final String? phone;
  final String? nationalId;
  final String? address;
  final double? basicSalary;
  final String? notes;

  UserEntity({
    required this.uId,
    required this.name,
    required this.phone,
    required this.image,
    required this.userType,
    required this.joiningDate,
    required this.directManager,
    required this.areaManager,
    required this.territory,
    this.email,
    this.nationalId,
    this.address,
    this.basicSalary,
    this.notes,
    required this.employmentStatus,
  });
}
