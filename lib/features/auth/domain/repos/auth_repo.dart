import 'package:medical_sales/core/errors/failures.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failures, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String image,
  });

  Future<Either<Failures, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  // Future<Either<Failures, UserEntity>> signInWithGoogle();

  // Future<Either<Failures, UserEntity>> signInWithFacebook();

  Future addUserData({required UserEntity user});
  Future getUserData({required String uId});
  Future<Either<Failures, void>> updateUserData({required UserEntity user});
  Future<Either<Failures, void>> updateUserImage(
      {required String uId, required String image});
  Future saveUserLocally({required UserEntity user});
  Future updateUserLocally({required UserEntity user});
  Future deleteUserLocally();
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future updateUserEmail({required String newEmail});

  Future signOut();
}
