import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/loading_dialog.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:medical_sales/features/main/presentation/views/main_view.dart';

class SignInViewBlocConsumer extends StatelessWidget {
  const SignInViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          loadingDialog(context);
        }
        if (state is SignInSuccess) {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(MainView.routeName, (route) => false);
        }
        if (state is SignInFailed) {
          print('SignInFailed: ${state.errMessage}');
          Navigator.pop(context);
          customDialog(
            context,
            title: state.errMessage,
            image: Assets.imagesErrors,
          );
        }
      },
      builder: (context, state) {
        return const CustomScrollView(
          slivers: [SliverToBoxAdapter(child: SignInViewBody())],
        );
      },
    );
  }
}
