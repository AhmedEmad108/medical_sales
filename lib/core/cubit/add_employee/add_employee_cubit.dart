import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit(this.authRepo) : super(AddEmployeeInitial());
    final AuthRepo authRepo;

  Future<void> addEmployee({
    required UserEntity user,
  }) async {
    emit(AddEmployeeLoading());
    final result = await authRepo.signUp(user: user,);
    result.fold(
      (failure) async {
        emit(AddEmployeeFailed(errMessage: failure.message));
      },
      (userEntity) async {
        emit(AddEmployeeSuccess());
      },
    );
  }
}
