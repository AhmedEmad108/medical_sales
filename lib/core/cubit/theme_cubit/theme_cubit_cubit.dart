import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medical_sales/core/services/shared_prefrences_singletone.dart';
import 'package:meta/meta.dart';

part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void changeTheme({required String themeMode}) async {
    await Prefs.setString('themeMode', themeMode);
    emit(ThemeChangedState(themeMode: themeMode));
  }
}
