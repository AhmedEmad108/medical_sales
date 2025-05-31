import 'package:flutter/material.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_password_text_field.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/features/auth/presentation/views/resetpassword/success_reset_password_view.dart';
import 'package:medical_sales/generated/l10n.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({
    super.key,
  });

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String password, confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Text(
              S.of(context).create_new_password,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              S.of(context).your_new_password,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomPasswordTextField(
              onSaved: (value) {
                password = value!;
              },
              label: S.of(context).password,
              hintText: S.of(context).enter_your_password,
            ),

            const SizedBox(
              height: 20,
            ),
            CustomPasswordTextField(
              onSaved: (value) {
                confirmPassword = value!;
              },
              label: S.of(context).confirm_password,
              hintText: S.of(context).enter_confirm_your_password,
            ),
            const SizedBox(
              height: 33,
            ),
            CustomButton(
              title: S.of(context).save,
              buttonColor: AppColor.primaryColor,
              textStyle: AppStyle.styleBold24().copyWith(
                color: AppColor.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  SuccessResetPasswordView.routeName,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
