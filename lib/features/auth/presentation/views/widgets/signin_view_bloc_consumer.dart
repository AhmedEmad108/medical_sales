import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/loading_dialog.dart';
import 'package:medical_sales/features/auth/presentation/cubits/signin_cubit/sign_in_cubit.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:medical_sales/features/main/presentation/views/main_view.dart';

class SignInViewBlocConsumer extends StatelessWidget {
  const SignInViewBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          loadingDialog(context);
        }
        if (state is SignInSuccess) {
          Navigator.pop(context);
          Navigator.of(context).pushNamedAndRemoveUntil(
            MainView.routeName,
            (route) => false,
          );
        }
        if (state is SignInError) {
          Navigator.pop(context);
          customDialog(
            context,
            title: state.message,
            image: Assets.imagesErrors,
          );
        }
      },
      builder: (context, state) {
        return const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SignInViewBody(),
            )
          ],
        );
      },
    );
  }
}
