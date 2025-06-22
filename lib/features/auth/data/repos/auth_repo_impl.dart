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

  // @override
  // Future<void> signUp({
  //   required UserEntity user,
  //   required String password,
  // }) async {
  //   // تحقق إذا كان الاسم مستخدم من قبل
  //   final existing =
  //       await usersCollection.where('name', isEqualTo: user.name).get();
  //   if (existing.docs.isNotEmpty) {
  //     throw Exception('الاسم مستخدم من قبل');
  //   }
  //   final userMap = UserModel.fromEntity(user).toMap();
  //   userMap['password'] = password; // إضافة الباسورد صريح أو مشفر حسب رغبتك
  //   await usersCollection.add(userMap);
  // }

  // @override
  // Future<UserEntity?> signIn({
  //   required String name,
  //   required String password,
  //   required String userType,
  // }) async {
  //   final result =
  //       await usersCollection
  //           .where('name', isEqualTo: name)
  //           .where('password', isEqualTo: password)
  //           .where('userType', isEqualTo: userType)
  //           .get();
  //   if (result.docs.isNotEmpty) {
  //     final data = result.docs.first.data();
  //     return UserModel.fromJson(data);
  //   }
  //   return null;
  // }

  @override
  Future<Either<Failures, UserEntity>> signUp({
    // required String email,
    required UserEntity user,
    required String password,
    // required String name,
    // required String phone,
    // required String image,
    // required String userType, // Changed from role to userType
  }) async {
    User? users;

    try {
      users = await firebaseAuthService.createUserWithNameAndPassword(
        name: user.name,
        password: password,
      );

      // user = await firebaseAuthService.createUserWithNameAndPassword(
      //   name: name,
      //   password: password,
      // );
      var userEntity = UserEntity(
        uId: users.uid,
        name: user.name,
        phone: user.phone,
        image: user.image,
        userType: user.userType,
        email: users.email ?? '',
        employeeStatus: user.employeeStatus,
        joiningDate: user.joiningDate,
        territory: user.territory,
      );
      await addUserData(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      // await deleteUser(user);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      // await deleteUser(user);
      log('Exception in createUserWithEmailAndPassword: ${e.toString()}');
      return Left(
        ServerFailure(message: 'Something went wrong. Please try again later.'),
      );
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signIn({
    required String name,
    required String password,
    required String userType, // Changed from role to userType
  }) async {
    try {
      final user = await firebaseAuthService.signInWithNameAndPassword(
        name: name,
        password: password,
      );

      final userEntity = await getUserData(uId: user.uid);
      await saveUserLocally(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      log('Exception in signIn: ${e.toString()}');
      return Left(
        ServerFailure(message: 'حدث خطأ ما. الرجاء المحاولة مرة أخرى.'),
      );
    }
  }

  @override
  Future<void> deleteUser() async {
    await firebaseAuthService.deleteUser();
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
