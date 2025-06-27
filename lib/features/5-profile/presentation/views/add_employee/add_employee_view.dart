import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/core/cubit/add_employee/add_employee_cubit.dart';
import 'package:medical_sales/core/services/get_it.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/widgets/add_employee_bloc_consumer.dart';
import 'package:medical_sales/features/auth/domain/repos/auth_repo.dart';
import 'package:medical_sales/generated/l10n.dart';

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key});
  static const routeName = '/add-employee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: S.of(context).add_employee,
        icon: true,
      ),
      body: BlocProvider(
        create: (context) => AddEmployeeCubit(getIt<AuthRepo>()),
        child: AddEmployeeBlocConsumer(),
      ),
    );
  }
}
