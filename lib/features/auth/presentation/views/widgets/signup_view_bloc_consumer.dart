import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/loading_dialog.dart';
import 'package:medical_sales/features/auth/presentation/cubits/signup_cubit/sign_up_cubit.dart';
import 'package:medical_sales/features/auth/presentation/views/signin_view.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignUPViewBlocConsumer extends StatelessWidget {
  const SignUPViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          loadingDialog(context);
        }
        if (state is SignUpSuccess) {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            SignInView.routeName,
            arguments: state.userEntity.email,
          );
        }
        if (state is SignUpError) {
          Navigator.pop(context);
          customDialog(
            context,
            title: state.message,
            image: Assets.imagesErrors,
          );
        }
      },
      builder: (context, state) {
        return const SignupViewBody();
      },
    );
  }
}
