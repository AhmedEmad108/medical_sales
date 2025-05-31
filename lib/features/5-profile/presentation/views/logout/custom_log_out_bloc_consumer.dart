import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/signout_cubit/sign_out_cubit.dart';
import 'package:medical_sales/core/services/get_it.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/loading_dialog.dart';
import 'package:medical_sales/features/5-profile/presentation/views/logout/custom_log_out_item.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:medical_sales/features/auth/presentation/views/signin_view.dart';

class CustomLogOutBlocConsumer extends StatelessWidget {
  const CustomLogOutBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutCubit(getIt<AuthRepo>()),
      child: BlocConsumer<SignOutCubit, SignOutState>(
        listener: (context, state) {
          if (state is SignOutLoading) {
            loadingDialog(context);
          }
          if (state is SignOutSuccess) {
            Navigator.pop(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
                SignInView.routeName, (route) => false);
          }
          if (state is SignOutError) {
            Navigator.pop(context);
            customDialog(
              context,
              title: state.message,
              image: Assets.imagesErrors,
            );
          }
        },
        builder: (context, state) {
          return CustomLogOutItem();
        },
      ),
    );
  }
}
