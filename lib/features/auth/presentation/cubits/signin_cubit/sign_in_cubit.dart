import 'package:bloc/bloc.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepo) : super(SignInInitial());
  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword({
    required String name,
    required String password,
  }) async {
    emit(SignInLoading());
    final result = await authRepo.signIn(
      name: name,
      password: password,
    );
    result.fold(
      (failure) {
        emit(SignInError(message: failure.message));
      },
      (userEntity) {
        emit(SignInSuccess(userEntity: userEntity));
      },
    );
  }

  // Future<void> signInWithGoogle() async {
  //   emit(SignInLoading());
  //   final result = await authRepo.signInWithGoogle();
  //   result.fold(
  //     (failure) {
  //       emit(SignInError(message: failure.message));
  //     },
  //     (userEntity) {
  //       emit(SignInSuccess(userEntity: userEntity));
  //     },
  //   );
  // }

  // Future<void> signInWithFacebook() async {
  //   emit(SignInLoading());
  //   final result = await authRepo.signInWithFacebook();
  //   result.fold(
  //     (failure) {
  //       emit(SignInError(message: failure.message));
  //     },
  //     (userEntity) {
  //       emit(SignInSuccess(userEntity: userEntity));
  //     },
  //   );
  // }

}
