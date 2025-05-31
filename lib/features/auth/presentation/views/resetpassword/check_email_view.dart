import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/auth/presentation/views/resetpassword/widget/check_email_view_body.dart';
import 'package:medical_sales/generated/l10n.dart';

class CheckEmailView extends StatelessWidget {
  const CheckEmailView({super.key});
  static const routeName = '/check_email_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,
          title: S.of(context).check_your_email, icon: true),
      body: const CheckEmailViewBody(),
    );
  }
}
