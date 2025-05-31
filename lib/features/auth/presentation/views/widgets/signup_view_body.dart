import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/custom_password_text_field.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/auth/presentation/cubits/signup_cubit/sign_up_cubit.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/custom_image_picker.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/dont_have_account_widget.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/terms_and_condition.dart';
import 'package:medical_sales/generated/l10n.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  late bool isTermsAccepted = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String email, password, confirmPassword, userName, phone;
  // File? image;
  String? urlImage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
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
              CustomImagePickier(
                radius: 70,
                onFileChanged: (String? value) {
                  urlImage = value;
                },
                auth: true,
              ),
              // Text(
              //   'Create your new account',
              //   style: AppStyle.styleRegular26(context),
              // ),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                hintText: S.of(context).enter_name,
                labels: S.of(context).name,
                onSaved: (value) {
                  userName = value!;
                },
                validator: (value) {
                  return validInput(
                    context: context,
                    val: value!,
                    type: 'name',
                    max: 20,
                    min: 3,
                  );
                },
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(Icons.person_outline),
              ),
              const SizedBox(
                height: 16,
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
              CustomTextField(
                hintText: S.of(context).enter_phone,
                labels: S.of(context).phone,
                onSaved: (value) {
                  phone = value!;
                },
                validator: (value) {
                  return validInput(
                    context: context,
                    val: value!,
                    type: 'phone',
                    max: 30,
                    min: 9,
                  );
                },
                keyboardType: TextInputType.phone,
                suffixIcon: const Icon(Icons.phone_android_outlined),
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
              CustomPasswordTextField(
                onSaved: (value) {
                  confirmPassword = value!;
                },
                label: S.of(context).confirm_password,
                hintText: S.of(context).enter_confirm_your_password,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTermsAndCondition(
                onChanged: (value) {
                  isTermsAccepted = value;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 33,
              ),
              CustomButton(
                title: S.of(context).signup,
                buttonColor: AppColor.primaryColor,
                textStyle: AppStyle.styleBold24().copyWith(
                  color: AppColor.white,
                ),
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (password == confirmPassword) {
                      // final bytes = image!.readAsBytesSync();
                      // String base64Image = base64Encode(bytes);
                      if (isTermsAccepted) {
                        context
                            .read<SignUpCubit>()
                            .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                              name: userName,
                              phone: phone,
                              image: urlImage ?? imageProfile,
                            );
                        // String? imageUrl;
                        // if (image == null) {
                        //   imageUrl = await uploadImageToFirebase(image!);
                        // } else {
                        //   context
                        //       .read<SignUpCubit>()
                        //       .createUserWithEmailAndPassword(
                        //         email: email,
                        //         password: password,
                        //         name: userName,
                        //         phone: phone,
                        //         image: await uploadImageToFirebase(image!),
                        //       );
                        // }
                      } else {
                        customDialog(context,
                            title: 'Please accept terms and conditions');
                      }
                    } else {
                      customDialog(
                        context,
                        title: 'Password and confirm password not match',
                      );
                    }
                  } else {
                    autoValidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
              const SizedBox(
                height: 33,
              ),
              HaveOrDontHaveAccountWidget(
                text: S.of(context).already_have_an_account,
                text2: S.of(context).signin,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 33,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
