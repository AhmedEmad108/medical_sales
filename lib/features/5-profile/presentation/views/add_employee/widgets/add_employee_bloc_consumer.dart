import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_images.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/loading_dialog.dart';
import 'package:medical_sales/core/utils/show_snackbar.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/widgets/add_employee_view_body.dart';
import 'package:medical_sales/generated/l10n.dart';

class AddEmployeeBlocConsumer extends StatelessWidget {
  const AddEmployeeBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          loadingDialog(context);
        }
        if (state is SignUpSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar(
            context,
            S.of(context).success_added_employee,
            AppColor.green,
          );
        }
        if (state is SignInFailed) {
          Navigator.pop(context);
          customDialog(
            context,
            title: state.errMessage,
            image: Assets.imagesErrors,
          );
        }
      },
      builder: (context, state) {
        return const AddEmployeeViewBody();
      },
    );
  }
}
