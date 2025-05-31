import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/theme_cubit/theme_cubit_cubit.dart';
import 'package:medical_sales/core/services/shared_prefrences_singletone.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_listtile.dart';
import 'package:medical_sales/features/5-profile/data/models/theme_class.dart';
import 'package:medical_sales/generated/l10n.dart';

class CustomChangeThemeItem extends StatelessWidget {
  const CustomChangeThemeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<ThemeClass> themeList = [
      ThemeClass(theme: 'light', name: S.of(context).light_mode),
      ThemeClass(theme: 'dark', name: S.of(context).dark_mode),
    ];
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        String theme = Prefs.getString('themeMode');
        return CustomListTile(
          title: S.of(context).change_theme,
          icon: Icons.dark_mode_outlined,
          trailing: DropdownButton<String>(
            value: theme,
            underline: const SizedBox(),
            borderRadius: BorderRadius.circular(8),
            elevation: 0,
            items: [
              for (var i = 0; i < themeList.length; i++)
                DropdownMenuItem<String>(
                  value: themeList[i].theme,
                  child: Text(
                    themeList[i].name,
                    style: AppStyle.styleSemiBold22(),
                  ),
                ),
            ],
            onChanged: (value) {
              context.read<ThemeCubit>().changeTheme(themeMode: value!);
            },
          ),
        );
      },
    );
  }
}
