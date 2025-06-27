import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/errors/exceptions.dart';
import 'package:medical_sales/core/errors/failures.dart';
import 'package:medical_sales/core/services/database_service.dart';
import 'package:medical_sales/core/services/firebase_auth_service.dart';
import 'package:medical_sales/core/services/shared_prefrences_singletone.dart';
import 'package:medical_sales/core/utils/backend_endpoint.dart';
import 'package:medical_sales/features/auth/data/model/user_model.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  AuthRepoImpl({
    required this.firebaseAuthService,
    required this.databaseService,
  });

  final usersCollection = FirebaseFirestore.instance.collection(
    BackendEndpoint.userData,
  );

  @override
  Future<Either<Failures, UserEntity>> signUp({
    required UserEntity user,
    required String password,
  }) async {
    try {
      // جرب تجيب المستخدم بالاسم (document id = name)
      final doc =
          await usersCollection
              .doc(user.name.toLowerCase().replaceAll(' ', ''))
              .get();
      if (doc.exists) {
        return Left(ServerFailure(message: 'اسم المستخدم مستخدم من قبل'));
      }

      // أنشئ Map من بيانات المستخدم
      final userMap = UserModel.fromEntity(user).toMap();
      userMap['password'] = password;

      // أضف المستخدم بالاسم كـ document id
      await usersCollection
          .doc(user.name.toLowerCase().replaceAll(' ', ''))
          .set(userMap);

      final userEntity = user.copyWith(
        uId: user.name.toLowerCase().replaceAll(' ', ''),
      );
      return Right(userEntity);
    } catch (e) {
      return Left(ServerFailure(message: 'حدث خطأ أثناء التسجيل'));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signIn({
    required String name,
    required String password,
    required String userType,
  }) async {
    try {
      final doc =
          await usersCollection
              .doc(name.toLowerCase().replaceAll(' ', ''))
              .get();

      if (!doc.exists) {
        return Left(
          ServerFailure(message: 'اسم المستخدم أو كلمة المرور غير صحيح.'),
        );
      }

      final userData = doc.data()!;
      if ((userData['password']?.toString() ?? '') != password) {
        return Left(
          ServerFailure(message: 'اسم المستخدم أو كلمة المرور غير صحيح.'),
        );
      }

      if ((userData['userType'] ?? '').toLowerCase() !=
          userType.toLowerCase()) {
        return Left(ServerFailure(message: 'نوع المستخدم غير صحيح.'));
      }

      final status =
          (userData['employeeStatus'] ?? userData['userStatus'] ?? '')
              .toLowerCase();
      if (status != 'active') {
        return Left(ServerFailure(message: 'الحساب غير مفعل.'));
      }

      final userEntity = UserEntity(
        uId: name.toLowerCase().replaceAll(
          ' ',
          '',
        ), // لأن ال document id هو الاسم
        name: userData['name'],
        phone: userData['phone'],
        image: userData['image'],
        userType: userData['userType'],
        admin: userData['admin'],
        email: userData['email'],
        employeeStatus: userData['employeeStatus'],
        joiningDate: userData['joiningDate'],
        territory: userData['territory'],
        address: userData['address'],
        areaManager: userData['areaManager'],
        basicSalary: userData['basicSalary'],
        directManager: userData['directManager'],
        nationalId: userData['nationalId'],
        notes: userData['notes'],
        password: userData['password'],
      );
      await saveUserLocally(user: userEntity);

      return Right(userEntity);
    } catch (e) {
      return Left(ServerFailure(message: 'حدث خطأ أثناء تسجيل الدخول'));
    }
  }

  // @override
  // Future<Either<Failures, UserEntity>> signUp({
  //   required UserEntity user,
  //   required String password,
  // }) async {
  //   try {
  //     // تحقق لو فيه اسم أو إيميل أو رقم قومي متكرر (حسب احتياجك)
  //     final existing =
  //         await usersCollection.where('name', isEqualTo: user.name).get();
  //     if (existing.docs.isNotEmpty) {
  //       return Left(ServerFailure(message: 'اسم المستخدم مستخدم من قبل'));
  //     }

  //     // أنشئ Map من بيانات المستخدم
  //     final userMap = UserModel.fromEntity(user).toMap();
  //     userMap['password'] =
  //         password; // تخزين الباسورد كـ نص عادي (لو عايز ممكن تعمله هاش)

  //     // إضافة المستخدم
  //     final docRef = await usersCollection.add(userMap);
  //     var userEntity = UserEntity(
  //       uId: docRef.id,
  //       name: user.name,
  //       password: user.password,
  //       phone: user.phone,
  //       image: user.image,
  //       userType: user.userType,
  //       admin: user.admin,
  //       email: user.email,
  //       employeeStatus: user.employeeStatus,
  //       joiningDate: user.joiningDate,
  //       territory: user.territory,
  //       address: user.address,
  //       areaManager: user.areaManager,
  //       basicSalary: user.basicSalary,
  //       directManager: user.directManager,
  //       nationalId: user.nationalId,
  //       notes: user.notes,
  //     );

  //     await addUserData(user: userEntity);

  //     // رجع بيانات المستخدم بعد التسجيل
  //     // If you want to return the user with the new uId, create a new UserEntity manually:

  //     return Right(userEntity);
  //   } on CustomException catch (e) {
  //     // await deleteUser(u);
  //     return Left(ServerFailure(message: e.message));
  //   } catch (e) {
  //     // await deleteUser(user);
  //     log('Exception in createUserWithEmailAndPassword: ${e.toString()}');
  //     return Left(
  //       ServerFailure(message: 'Something went wrong. Please try again later.'),
  //     );
  //   }
  // }

  // @override
  // Future<Either<Failures, UserEntity>> signIn({
  //   required String name,
  //   required String password,
  //   required String userType,
  // }) async {
  //   try {
  //     // دور على المستخدم بالاسم فقط
  //     final userQuery =
  //         await usersCollection.where('name', isEqualTo: name).get();

  //     if (userQuery.docs.isEmpty) {
  //       return Left(
  //         ServerFailure(message: 'اسم المستخدم أو كلمة المرور غير صحيح.'),
  //       );
  //     }

  //     final userData = userQuery.docs.first.data();

  //     // تحقق من الباسورد
  //     if ((userData['password']?.toString() ?? '') != password) {
  //       return Left(
  //         ServerFailure(message: 'اسم المستخدم أو كلمة المرور غير صحيح.'),
  //       );
  //     }

  //     // تحقق من نوع المستخدم
  //     if ((userData['userType'] ?? '').toLowerCase() !=
  //         userType.toLowerCase()) {
  //       return Left(ServerFailure(message: 'نوع المستخدم غير صحيح.'));
  //     }

  //     // تحقق من حالة المستخدم (Active)
  //     final status =
  //         (userData['employeeStatus'] ?? userData['userStatus'] ?? '')
  //             .toLowerCase();
  //     if (status != 'active') {
  //       return Left(ServerFailure(message: 'الحساب غير مفعل.'));
  //     }

  //     // رجّع بيانات المستخدم
  //     final userEntity = UserEntity(
  //       uId: userData['uId'] ?? userQuery.docs.first.id,
  //       name: userData['name'],
  //       password: userData['password'],
  //       phone: userData['phone'],
  //       image: userData['image'],
  //       userType: userData['userType'],
  //       admin: userData['admin'],
  //       email: userData['email'],
  //       employeeStatus: userData['employeeStatus'],
  //       joiningDate: userData['joiningDate'],
  //       territory: userData['territory'],
  //       address: userData['address'],
  //       areaManager: userData['areaManager'],
  //       basicSalary: userData['basicSalary'],
  //       directManager: userData['directManager'],
  //       nationalId: userData['nationalId'],
  //       notes: userData['notes'],
  //     );
  //     await saveUserLocally(user: userEntity);
  //     return Right(userEntity);
  //   } catch (e) {
  //     return Left(ServerFailure(message: 'حدث خطأ أثناء تسجيل الدخول'));
  //   }
  // }

  @override
  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.userData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future getUserData({required String uId}) async {
    try {
      var userData = await databaseService.getData(
        path: BackendEndpoint.userData,
        documentId: uId,
      );
      return UserModel.fromJson(userData);
    } catch (e) {
      log('Exception in getUserData: ${e.toString()}');
      return ServerFailure(message: e.toString());
    }
  }

  @override
  Future<Either<Failures, void>> updateUserData({
    required UserEntity user,
  }) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoint.userData,
        data: UserModel.fromEntity(user).toMap(),
        documentId: user.uId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> updateUserImage({
    required String uId,
    required String image,
  }) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoint.userData,
        data: {'image': image},
        documentId: uId,
      );
      // await updateUserLocally(user: );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future updateUserLocally({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString(kUserData, jsonData);
  }

  @override
  Future saveUserLocally({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString(kUserData, jsonData);
  }

  @override
  Future deleteUserLocally() async {
    await Prefs.deleteString(kUserData);
  }

  @override
  Future signOut() async {
    await deleteUserLocally();
    await firebaseAuthService.signOut();
    // await Prefs.deleteAll();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await firebaseAuthService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> updateUserEmail({required String newEmail}) async {
    await firebaseAuthService.updateEmail(newEmail);
  }
}
