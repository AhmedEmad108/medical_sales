import 'package:medical_sales/core/errors/failures.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  
  // Future<void> signUp({
  //   required UserEntity user,
  //   required String password,
  // });

  // Future<UserEntity?> signIn({
  //   required String name,
  //   required String password,
  //   required String userType,
  // });
  
  Future<Either<Failures, UserEntity>> signUp({
    // required String email,
    
    required UserEntity user,
    required String password,
    // required String name,
    // required String phone,
    // required String image,
    // required String userType,
  });

  Future<Either<Failures, UserEntity>> signIn({
    required String name,
    required String password,
    required String userType,
  });

  Future addUserData({required UserEntity user});
  Future getUserData({required String uId});
  Future<Either<Failures, void>> updateUserData({required UserEntity user});
  Future<Either<Failures, void>> updateUserImage({
    required String uId,
    required String image,
  });
  Future saveUserLocally({required UserEntity user});
  Future updateUserLocally({required UserEntity user});
  Future deleteUserLocally();
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future updateUserEmail({required String newEmail});

  Future signOut();
  Future<void> deleteUser();
}
