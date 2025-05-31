import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/change_password/change_password_cubit.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/loading_dialog.dart';
import 'package:medical_sales/core/utils/show_snackbar.dart';
import 'package:medical_sales/features/5-profile/presentation/views/chang_password/widgets/change_password_view_body.dart';
import 'package:medical_sales/generated/l10n.dart';
class ChangePasswordViewBodyBlocConsumer extends StatelessWidget {
  const ChangePasswordViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordLoading) {
          loadingDialog(context);
        }
        if (state is ChangePasswordSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar(
            context,
            S.of(context).password_updated_successfully,
            AppColor.green,
          );
        }
        if (state is ChangePasswordFailure) {
          Navigator.pop(context);
          customDialog(
            context,
            title: state.error,
            image: Assets.imagesErrors,
          );
        }
      },
      builder: (context, state) {
        return ChangePasswordViewBody();
      },
    );
  }
}
