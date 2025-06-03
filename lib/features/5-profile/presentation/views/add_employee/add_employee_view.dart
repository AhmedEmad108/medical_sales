import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/widgets/add_employee_bloc_consumer.dart';
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
      body: AddEmployeeBlocConsumer(),
    );
  }
}
