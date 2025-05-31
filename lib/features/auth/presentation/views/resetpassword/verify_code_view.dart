import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/auth/presentation/views/resetpassword/reset_password_view.dart';
import 'package:medical_sales/features/auth/presentation/views/resetpassword/widget/verify_code_view_body.dart';
import 'package:medical_sales/generated/l10n.dart';

class VerifyCodeResetPassView extends StatelessWidget {
  const VerifyCodeResetPassView({super.key, required this.email});
  static const routeName = '/verifyCodeResetPassView';

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,
          title: S.of(context).verification_code, icon: true),
      body: VerifyCodeViewBody(
        onTap: () {
          Navigator.of(context).pushNamed(ResetPasswordView.routeName);
        },
        email: email,
      ),
    );
  }
}
