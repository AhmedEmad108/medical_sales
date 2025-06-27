import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart';
import 'package:medical_sales/core/helper_functions/get_user.dart';
import 'package:medical_sales/core/utils/custom_listtile.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/add_employee_view.dart';
import 'package:medical_sales/features/5-profile/presentation/views/chang_password/change_password_view.dart';
import 'package:medical_sales/features/5-profile/presentation/views/edit_profile/edit_profile_view.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:medical_sales/generated/l10n.dart';
import 'package:medical_sales/features/5-profile/presentation/views/logout/custom_log_out.dart';
import 'package:medical_sales/features/5-profile/presentation/views/widgets/custom_change_lang_item.dart';
import 'package:medical_sales/features/5-profile/presentation/views/widgets/custom_change_theme_item.dart';

class CustomProfileItem extends StatefulWidget {
  const CustomProfileItem({super.key});

  @override
  State<CustomProfileItem> createState() => _CustomProfileItemState();
}

class _CustomProfileItemState extends State<CustomProfileItem> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    UserEntity user = getUser();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Visibility(
            visible: user.admin == 'true',
            child: CustomListTile(
              title: S.of(context).add_employee,
              icon: Icons.add_circle_outline,
              onTap: () {
                Navigator.of(context).pushNamed(AddEmployeeView.routeName);
              },
            ),
          ),
          CustomListTile(
            title: S.of(context).edit_profile,
            icon: Icons.edit_outlined,
            onTap: () {
              Navigator.of(context).pushNamed(EditProfileView.routeName);
            },
          ),
          CustomListTile(
            title: S.of(context).change_password,
            icon: Icons.lock_outline,
            onTap: () {
              Navigator.of(context).pushNamed(ChangePasswordView.routeName);
            },
          ),

          const CustomChangeThemeItem(),
          const CustomChangeLangItem(),
          const CustomLogOut(),
        ],
      ),
    );
  }
}
