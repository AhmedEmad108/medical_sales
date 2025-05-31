import 'package:bloc/bloc.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo) : super(SignUpInitial());
  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({
    required String userType,
    required String password,
    required String name,
    required String phone,
    required String image,
  }) async {
    emit(SignUpLoading());
    final result = await authRepo.createUser(
      userType: userType,
      password: password,
      name: name,
      phone: phone,
      image: image,
    );

    result.fold(
      (failure) {
        emit(SignUpError(message: failure.message));
      },
      (userEntity) {
        emit(SignUpSuccess(userEntity: userEntity));
      },
    );
  }
}
