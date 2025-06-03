part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

// Get User States
final class GetUserLoading extends UserState {}

final class GetUserSuccess extends UserState {
  final UserEntity user;
  
  GetUserSuccess({required this.user});
}

final class GetUserFailed extends UserState {
  final String errMessage;
  
  GetUserFailed({required this.errMessage});
}

// Edit User States
final class EditUserLoading extends UserState {}

final class EditUserSuccess extends UserState {
  // final UserEntity user;
  
  // EditUserSuccess({required this.user});
}

final class EditUserFailed extends UserState {
  final String errMessage;
  
  EditUserFailed({required this.errMessage});
}

// Edit User Image States
final class EditUserImageLoading extends UserState {}

final class EditUserImageSuccess extends UserState {}

final class EditUserImageFailed extends UserState {
  final String errMessage;
  
  EditUserImageFailed({required this.errMessage});
}

// Sign Out States
final class SignOutLoading extends UserState {}

final class SignOutSuccess extends UserState {}

final class SignOutFailed extends UserState {
  final String errMessage;
  
  SignOutFailed({required this.errMessage});
}


final class ChangeEmailLoading extends UserState {}

final class ChangeEmailSuccess extends UserState {}

final class ChangeEmailFailed extends UserState {
  final String error;

  ChangeEmailFailed({required this.error});

}


class SignUpLoading extends UserState {}

class SignUpSuccess extends UserState {}

class SignUpFailed extends UserState {
  final String errMessage;
  SignUpFailed({required this.errMessage});
}

class SignInLoading extends UserState {}

class SignInSuccess extends UserState {
  final dynamic userData; // UserEntity
  SignInSuccess({required this.userData});
}

class SignInFailed extends UserState {
  final String errMessage;
  SignInFailed({required this.errMessage});
}


// part of 'user_cubit.dart';

// @immutable
// sealed class UserState {}

// final class UserInitial extends UserState {}

// final class GetUserLoading extends UserState {}

// final class GetUserSuccess extends UserState {
//   final UserEntity user;
//   GetUserSuccess({required this.user});
// }

// final class GetUserFailed extends UserState {
//   final String errMessage;
//   GetUserFailed({required this.errMessage});
// }

// final class EditUserLoading extends UserState {}

// final class EditUserSuccess extends UserState {
//   final UserEntity user;
//   EditUserSuccess({required this.user});
// }

// final class EditUserFailed extends UserState {
//   final String errMessage;
//   EditUserFailed({required this.errMessage});
// }

// final class EditUserImageLoading extends UserState {}

// final class EditUserImageSuccess extends UserState {

// }

// final class EditUserImageFailed extends UserState {
//   final String errMessage;
//   EditUserImageFailed({required this.errMessage});
// }
