import 'package:flutter/material.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/auth/presentation/views/resetpassword/verify_code_view.dart';
import 'package:medical_sales/generated/l10n.dart';

class CheckEmailViewBody extends StatefulWidget {
  const CheckEmailViewBody({
    super.key,
  });

  @override
  State<CheckEmailViewBody> createState() => _CheckEmailViewBodyState();
}

class _CheckEmailViewBodyState extends State<CheckEmailViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String email;
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
            // Text(
            //   'Check Your Email',
            //   style: AppStyle.styleBold30(context),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Text(
              S.of(context).please_enter_your_email,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              labels: S.of(context).email,
              hintText: S.of(context).enter_email,
              onSaved: (value) {
                email = value!;
              },
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'email',
                  max: 30,
                  min: 10,
                );
              },
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(
              height: 33,
            ),
            CustomButton(
              title: S.of(context).check_your_email,
              buttonColor: AppColor.primaryColor,
              textStyle: AppStyle.styleBold24().copyWith(
                color: AppColor.white,
              ),
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.of(context).pushNamed(
                      VerifyCodeResetPassView.routeName,
                      arguments: email);
                } else {
                  autoValidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
