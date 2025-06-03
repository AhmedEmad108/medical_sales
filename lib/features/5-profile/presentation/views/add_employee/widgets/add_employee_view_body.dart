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
  TextEditingController emoloyeeNameController = TextEditingController();
  TextEditingController employeeTypeController = TextEditingController();
  TextEditingController joinDateController = TextEditingController();
  TextEditingController directManagerController = TextEditingController();
  TextEditingController areaManagerController = TextEditingController();
  TextEditingController territoryController = TextEditingController();
  TextEditingController emoloyeeStatusController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController basicSalaryController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late String emoloyeeName,
      employeeType,
      joinDate,
      directManager,
      areaManager,
      territory,
      emoloyeeStatus,
      email,
      phone,
      nationalId,
      address,
      basicSalary,
      notes,
      password,
      confirmPassword;
  String? urlImage;

  @override
  void dispose() {
    emoloyeeNameController.dispose();
    employeeTypeController.dispose();
    joinDateController.dispose();
    directManagerController.dispose();
    areaManagerController.dispose();
    territoryController.dispose();
    emoloyeeStatusController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nationalIdController.dispose();
    addressController.dispose();
    basicSalaryController.dispose();
    notesController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                hintText: S.of(context).enter_employee_name,
                labels: S.of(context).employee_name,
                controller: emoloyeeNameController,
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
                hintText: S.of(context).enter_employee_type,
                labels: S.of(context).employee_type,
                controller: employeeTypeController,
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
                suffixIcon: const Icon(Icons.work_outline),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_join_date,
                labels: S.of(context).join_date,
                controller: joinDateController,
                validator: (value) {
                  return validInput(
                    context: context,
                    val: value!,
                    type: 'date',
                    max: 10,
                    min: 10,
                  );
                },
                keyboardType: TextInputType.datetime,
                suffixIcon: const Icon(Icons.date_range_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_direct_manager,
                labels: S.of(context).direct_manager,
                controller: directManagerController,
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
                hintText: S.of(context).enter_area_manager,
                labels: S.of(context).area_manager,
                controller: areaManagerController,
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
                hintText: S.of(context).enter_territory,
                labels: S.of(context).territory,
                controller: territoryController,
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
                suffixIcon: const Icon(Icons.location_on_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_employee_status,
                labels: S.of(context).employee_status,
                controller: emoloyeeStatusController,
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
                hintText: S.of(context).enter_employee_email,
                labels: S.of(context).employee_email,
                controller: emailController,
                // validator: (value) {
                //   return validInput(
                //     context: context,
                //     val: value!,
                //     type: 'email',
                //     max: 30,
                //     min: 10,
                //   );
                // },
                keyboardType: TextInputType.emailAddress,
                suffixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_employee_phone,
                labels: S.of(context).employee_phone,
                controller: phoneController,
                // validator: (value) {
                //   return validInput(
                //     context: context,
                //     val: value!,
                //     type: 'phone',
                //     max: 30,
                //     min: 9,
                //   );
                // },
                keyboardType: TextInputType.phone,
                suffixIcon: const Icon(Icons.phone_android_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_employee_national_id,
                labels: S.of(context).employee_national_id,
                controller: nationalIdController,
                // validator: (value) {
                //   return validInput(
                //     context: context,
                //     val: value!,
                //     type: 'nationalId',
                //     max: 14,
                //     min: 14,
                //   );
                // },
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.person_outline),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).employee_enter_address,
                labels:  S.of(context).employee_address,
                controller: addressController,
                // validator: (value) {
                //   return validInput(
                //     context: context,
                //     val: value!,
                //     type: 'name',
                //     max: 20,
                //     min: 3,
                //   );
                // },
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(Icons.location_on_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_employee_basic_salary,
                labels: S.of(context).employee_basic_salary,
                controller: basicSalaryController,
                // validator: (value) {
                //   return validInput(
                //     context: context,
                //     val: value!,
                //     type: 'salary',
                //     max: 10,
                //     min: 1,
                //   );
                // },
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.monetization_on_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: S.of(context).enter_employee_notes,
                labels: S.of(context).employee_notes,
                controller: notesController,
                // validator: (value) {
                //   return validInput(
                //     context: context,
                //     val: value!,
                //     type: 'name',
                //     max: 100,
                //     min: 3,
                //   );
                // },
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(Icons.notes_outlined),
              ),
              const SizedBox(height: 16),
              CustomPasswordTextField(
                label: S.of(context).employee_password,
                // controller: passwordController,
                hintText: S.of(context).enter_employee_password,
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(height: 16),
              CustomPasswordTextField(
                label: S.of(context).confirm_employee_password,
                // controller: confirmPasswordController,
                hintText: S.of(context).enter_confirm_employee_password,
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
                          image: urlImage ?? '',
                          name: emoloyeeNameController.text,
                          userType: employeeTypeController.text,
                          joiningDate: joinDateController.text,
                          directManager: directManagerController.text,
                          areaManager: areaManagerController.text,
                          territory: territoryController.text,
                          employeeStatus: emoloyeeStatusController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          nationalId: nationalIdController.text,
                          address: addressController.text,
                          basicSalary: basicSalaryController.text,
                          notes: notesController.text,
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
