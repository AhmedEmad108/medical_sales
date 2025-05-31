import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/auth/presentation/views/resetpassword/widget/verify_code_view_body.dart';
import 'package:medical_sales/features/auth/presentation/views/signin_view.dart';

class VerifyCodeSignInView extends StatelessWidget {
  const VerifyCodeSignInView({super.key, required this.email});
  static const routeName = '/verifyCodeSignInView';
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Verification Code', icon: true),
      body: VerifyCodeViewBody(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SignInView.routeName,
            (route) => false,
          );
        },
        email: email,
      ),
    );
  }
}
