import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart' as user_cubit;
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/loading_dialog.dart';
import 'package:medical_sales/features/auth/presentation/cubits/signin_cubit/sign_in_cubit.dart' as signin_cubit;
import 'package:medical_sales/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:medical_sales/features/main/presentation/views/main_view.dart';

class SignInViewBlocConsumer extends StatelessWidget {
  const SignInViewBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<user_cubit.UserCubit, user_cubit.UserState>(
      listener: (context, state) {
        if (state is user_cubit.SignInLoading) {
          loadingDialog(context);
        }
        if (state is user_cubit.SignInSuccess) {
          Navigator.pop(context);
          Navigator.of(context).pushNamedAndRemoveUntil(
            MainView.routeName,
            (route) => false,
          );
        }
        if (state is user_cubit.SignInFailed) {
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
