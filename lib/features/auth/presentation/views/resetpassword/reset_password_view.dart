import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/auth/presentation/views/resetpassword/widget/reset_password_view_body.dart';
import 'package:medical_sales/generated/l10n.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  static const routeName = '/resetPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,
          title: S.of(context).reset_password, icon: true),
      body: const ResetPasswordViewBody(),
    );
  }
}
