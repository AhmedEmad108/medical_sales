import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart';
import 'package:medical_sales/core/helper_functions/get_user.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/core/widgets/custom_image_picker.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:medical_sales/generated/l10n.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key});

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  UserEntity user2 = getUser();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  // late String email, password, confirmPassword, userName, phone;
  String? urlImage;

  @override
  void initState() {
    userName.text = user2.name;
    phone.text = user2.phone!;
    urlImage = user2.image;
    super.initState();
  }

  @override
  void dispose() {
    userName.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }

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
            children: [
              const SizedBox(height: 20),
              CustomImagePicker(
                radius: 70,
                urlImage: urlImage,
                onFileChanged: (String? value) {
                  urlImage = value;
                },
              ),
              const SizedBox(height: 40),
              CustomTextField(
                hintText: S.of(context).enter_name,
                labels: S.of(context).name,
                controller: userName,
                onSaved: (value) {
                  userName.text = value!;
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
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_phone,
                labels: S.of(context).phone,
                controller: phone,
                onSaved: (value) {
                  phone.text = value!;
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
              const SizedBox(height: 16),
              CustomButton(
                title: S.of(context).edit_profile,
                buttonColor: AppColor.primaryColor,
                textStyle: AppStyle.styleBold24().copyWith(
                  color: AppColor.white,
                ),
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    UserEntity user = UserEntity(
                      uId: user2.uId,
                      userType: user2.userType,
                      name: userName.text,
                      password: user2.password,
                      phone: phone.text,
                      image: urlImage!,
                      joiningDate: user2.joiningDate,
                      admin: user2.admin,
                      notes: user2.notes,
                      address: address.text,
                      basicSalary: user2.basicSalary,
                      email: user2.email,
                      nationalId: user2.nationalId,
                      directManager: user2.directManager,
                      areaManager: user2.areaManager,
                      territory: user2.territory,
                      employeeStatus: user2.employeeStatus,
                    );
                    context.read<UserCubit>().editUser(user: user);
                  } else {
                    setState(() {
                      autoValidateMode = AutovalidateMode.always;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
