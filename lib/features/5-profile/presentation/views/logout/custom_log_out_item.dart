import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/signout_cubit/sign_out_cubit.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/custom_listtile.dart';
import 'package:medical_sales/generated/l10n.dart';

class CustomLogOutItem extends StatelessWidget {
  const CustomLogOutItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: S.of(context).logout,
      icon: Icons.logout_outlined,
      color: AppColor.red,
      trailing: const SizedBox(),
      onTap: () {
        customDialog(
          context,
          title: S.of(context).logout,
          textOk: S.of(context).logout,
          content: S.of(context).logout_message,
          onPressed: () {
            context.read<SignOutCubit>().signOut();
          },
        );
      },
    );
  }
}
