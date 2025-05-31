import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/5-profile/presentation/views/widgets/profile_view_body.dart';
import 'package:medical_sales/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: S.of(context).profile),
      body: ProfileViewBody(),
    );
  }
}
