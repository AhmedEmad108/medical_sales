import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/services/get_it.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:medical_sales/features/auth/presentation/cubits/signup_cubit/sign_up_cubit.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/signup_view_bloc_consumer.dart';
import 'package:medical_sales/generated/l10n.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'signupView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: customAppBar(context, title: S.of(context).signup, icon: true),
        body: const SafeArea(child: SignUPViewBlocConsumer()),
      ),
    );
  }
}
