import 'package:flutter/material.dart';
import 'package:medical_sales/features/5-profile/presentation/views/chang_password/change_password_view.dart';
import 'package:medical_sales/features/5-profile/presentation/views/edit_profile/edit_profile_view.dart';
import 'package:medical_sales/features/auth/presentation/views/signin_view.dart';
import 'package:medical_sales/features/main/presentation/views/main_view.dart';
import 'package:medical_sales/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case (SignInView.routeName):
      return MaterialPageRoute(builder: (context) => const SignInView());
    case (MainView.routeName):
      return MaterialPageRoute(builder: (context) => const MainView());
    case (EditProfileView.routeName):
      return MaterialPageRoute(builder: (context) => EditProfileView());
    case (ChangePasswordView.routeName):
      return MaterialPageRoute(builder: (context) => ChangePasswordView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
