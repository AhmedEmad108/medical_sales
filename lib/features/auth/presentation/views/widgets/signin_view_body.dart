import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_listtile.dart';
import 'package:medical_sales/core/utils/custom_password_text_field.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/auth/presentation/cubits/signin_cubit/sign_in_cubit.dart';
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
  late String name, password;
  String userTypeValue = 'Medical Representative';
  List<String> userType = ['Administrator', 'Medical Representative'];
  final TextEditingController _userTypeValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userTypeValue.text = userTypeValue; // Default value
  }

  @override
  void dispose() {
    _userTypeValue.dispose();
    super.dispose();
  }

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
            const SizedBox(height: 80),
            Center(
              child: SvgPicture.asset(
                Assets.imagesIcon,
                width: MediaQuery.of(context).size.width,
                height: 250,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).welcome_back,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: S.of(context).enter_name,
              labels: S.of(context).name,
              onSaved: (value) {
                name = value!;
              },
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'name',
                  max: 30,
                  min: 10,
                );
              },
              keyboardType: TextInputType.name,
              suffixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 16),
            CustomPasswordTextField(
              onSaved: (value) {
                password = value!;
              },
              label: S.of(context).password,
              hintText: S.of(context).enter_your_password,
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: S.of(context).enter_name,
              labels: S.of(context).name,
              onSaved: (value) {
                userTypeValue = value!;
              },
              controller: _userTypeValue,
              boolien: true,
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'name',
                  max: 30,
                  min: 10,
                );
              },
              keyboardType: TextInputType.name,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: DropdownButton<String>(
                  // value: userTypeValue,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(8),
                  elevation: 0,
                  items:
                      userType.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.toUpperCase(),
                            style: AppStyle.styleSemiBold22(),
                          ),
                        );
                      }).toList(),
                  // items: [
                  //   for (var i = 0; i < userType.length; i++)
                  //     DropdownMenuItem<String>(
                  //       value: userType[i].toLowerCase(),
                  //       child: Text(
                  //         userType[i].toUpperCase(),
                  //         style: AppStyle.styleSemiBold22(),
                  //       ),
                  //     ),
                  // ],
                  onChanged: (value) {
                    setState(() {
                      userTypeValue = value!;
                      _userTypeValue.text = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
            CustomButton(
              title: S.of(context).signin,
              buttonColor: AppColor.primaryColor,
              textStyle: AppStyle.styleBold24().copyWith(color: AppColor.white),
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<SignInCubit>().signInWithEmailAndPassword(
                    name: name,
                    password: password,
                    userType: userTypeValue,
                  );
                } else {
                  autoValidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 33),
          ],
        ),
      ),
    );
  }
}
