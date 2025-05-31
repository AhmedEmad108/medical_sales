import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_password_text_field.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/auth/presentation/cubits/signin_cubit/sign_in_cubit.dart';
import 'package:medical_sales/features/auth/presentation/views/signup_view.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/dont_have_account_widget.dart';
import 'package:medical_sales/generated/l10n.dart';
import 'package:svg_flutter/svg.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  bool isShowPassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String email, password;

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
            Center(
              child: SvgPicture.asset(
                Assets.imagesIcon,
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              S.of(context).welcome_back,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: S.of(context).enter_email,
              labels: S.of(context).email,
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
              height: 16,
            ),
            CustomPasswordTextField(
              onSaved: (value) {
                password = value!;
              },
              label: S.of(context).password,
              hintText: S.of(context).enter_your_password,
            ),
            const SizedBox(
              height: 16,
            ),
            
            const SizedBox(
              height: 16,
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, CheckEmailView.routeName);
            //         // Navigator.pushNamed(CheckEmailView.routeName);
            //       },
            //       child: Text(
            //         S.of(context).forget_password,
            //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //               color: AppColor.primaryColor,
            //             ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 33,
            // ),
            CustomButton(
              title: S.of(context).signin,
              buttonColor: AppColor.primaryColor,
              textStyle: AppStyle.styleBold24().copyWith(
                color: AppColor.white,
              ),
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<SignInCubit>().signInWithEmailAndPassword(
                      email: email, password: password);
                } else {
                  autoValidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            ),
            const SizedBox(
              height: 33,
            ),
            // HaveOrDontHaveAccountWidget(
            //   text: S.of(context).do_not_have_an_account,
            //   text2: S.of(context).signup,
            //   onTap: () {
            //     Navigator.of(context).pushNamed(SignupView.routeName);
            //   },
            // ),
            // const SizedBox(
            //   height: 33,
            // ),
            // const OrDivider(),
            // const SizedBox(
            //   height: 16,
            // ),
            // SocialLoginButton(
            //   text: S.of(context).sign_with_google,
            //   image: Assets.imagesGoogle,
            //   onTap: () {
            //     context.read<SignInCubit>().signInWithGoogle();
            //   },
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // SocialLoginButton(
            //   text: S.of(context).sign_with_facebook,
            //   image: Assets.imagesFacebook,
            //   onTap: () {
            //     context.read<SignInCubit>().signInWithFacebook();
            //   },
            // ),
            // const SizedBox(
            //   height: 33,
            // ),

            // Platform.isIOS
            //     ? Column(
            //         children: [
            //           const SizedBox(
            //             height: 16,
            //           ),
            //           SocialLoginButton(
            //             text: 'Sign in with Apple',
            //             image: Assets.imagesApple,
            //             onTap: () {},
            //           ),
            //         ],
            //       )
            //     : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
