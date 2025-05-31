import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/change_password/change_password_cubit.dart';
import 'package:medical_sales/core/services/get_it.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/5-profile/presentation/views/chang_password/widgets/change_password_view_body_bloc_consumer.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:medical_sales/generated/l10n.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});
  static const routeName = '/changePassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,
          title: S.of(context).change_password, icon: true),
      body: BlocProvider(
        create: (context) => ChangePasswordCubit(
          getIt<AuthRepo>(),
        ),
        child: ChangePasswordViewBodyBlocConsumer(),
      ),
    );
  }
}

