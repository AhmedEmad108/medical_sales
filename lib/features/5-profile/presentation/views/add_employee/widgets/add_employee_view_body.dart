import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/custom_password_text_field.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/core/widgets/custom_image_picker.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:medical_sales/generated/l10n.dart';

class AddEmployeeViewBody extends StatefulWidget {
  const AddEmployeeViewBody({super.key});

  @override
  State<AddEmployeeViewBody> createState() => _AddEmployeeViewBodyState();
}

class _AddEmployeeViewBodyState extends State<AddEmployeeViewBody> {
  late bool isTermsAccepted = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late String email, password, confirmPassword, userName, phone;
  String? urlImage;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomImagePicker(
                onFileChanged: (url) => urlImage = url,
                auth: true,
                radius: 70,
              ),
              const SizedBox(height: 33),
              CustomTextField(
                hintText: S.of(context).enter_name,
                labels: S.of(context).name,
                controller: nameController,
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
              // const SizedBox(height: 16),
              // CustomTextField(
              //   hintText: S.of(context).enter_email,
              //   labels: S.of(context).email,
              //   controller: emailController,
              //   validator: (value) {
              //     return validInput(
              //       context: context,
              //       val: value!,
              //       type: 'email',
              //       max: 30,
              //       min: 10,
              //     );
              //   },
              //   keyboardType: TextInputType.emailAddress,
              //   suffixIcon: const Icon(Icons.email_outlined),
              // ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_phone,
                labels: S.of(context).phone,
                controller: phoneController,
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
              const SizedBox(height: 16),
              CustomPasswordTextField(
                label: S.of(context).password,
                // controller: passwordController,
                hintText: S.of(context).enter_your_password,
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(height: 16),
              CustomPasswordTextField(
                label: S.of(context).confirm_password,
                // controller: confirmPasswordController,
                hintText: S.of(context).enter_confirm_your_password,
                onSaved: (value) {
                  confirmPassword = value!;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: S.of(context).add_employee,
                buttonColor: AppColor.primaryColor,
                textStyle: AppStyle.styleBold24().copyWith(
                  color: AppColor.white,
                ),
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (password == confirmPassword) {
                      context.read<UserCubit>().signUp(
                        user: UserEntity(
                          uId: '',
                          name: nameController.text,
                          image: urlImage ?? '',
                          userType: 'Medical Representative',
                          email: emailController.text,
                          joiningDate: '',
                          directManager: '',
                          areaManager: '',
                          territory: '',
                          employmentStatus: 'active',
                          phone: phoneController.text,
                        ),
                        password: password,
                      );
                    } else {
                      customDialog(
                        context,
                        title:
                            S
                                .of(context)
                                .password_and_confirm_password_not_match,
                      );
                    }
                  } else {
                    autoValidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
