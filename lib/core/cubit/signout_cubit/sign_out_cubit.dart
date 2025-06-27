import 'package:bloc/bloc.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/services/shared_prefrences_singletone.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(this.authRepo) : super(SignOutInitial());
  final AuthRepo authRepo;

  Future<void> signOut() async {
    emit(SignOutLoading());
    try {
      await authRepo.signOut();
      Prefs.deleteString(kUserData);
      Prefs.setBool(kIsLoggedIn, false);
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutError(message: e.toString()));
    }
  }
}
