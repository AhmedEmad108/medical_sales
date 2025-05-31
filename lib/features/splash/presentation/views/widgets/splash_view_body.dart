import 'package:flutter/material.dart';
import 'package:medical_sales/core/services/firebase_auth_service.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/features/auth/presentation/views/signin_view.dart';
import 'package:medical_sales/features/main/presentation/views/main_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuteNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(Assets.imagesAppLogo));
  }

  void excuteNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   SignInnView.routeName,
      //   (route) => false,
      // );
      // bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);

      var isLogedIn = FirebaseAuthService().isLoggedIn();

      if (isLogedIn) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainView.routeName,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SignInView.routeName,
          (route) => false,
        );
      }
    });
  }
}
