import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/services/get_it.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:medical_sales/features/auth/presentation/cubits/signin_cubit/sign_in_cubit.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/signin_view_bloc_consumer.dart';
import 'package:medical_sales/generated/l10n.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const routeName = 'loginView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: customAppBar(context, title: S.of(context).signin),
        body: const SafeArea(child: SignInViewBlocConsumer()),
      ),
    );
  }
}
