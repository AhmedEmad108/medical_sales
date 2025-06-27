import 'package:flutter/material.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/custom_date_picker_field.dart';
import 'package:medical_sales/core/widgets/custom_image_picker.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/widgets/add_employee_view_body.dart';
import 'package:medical_sales/generated/l10n.dart';

class CustomBasicInfoStep extends StatefulWidget {
  const CustomBasicInfoStep({
    super.key,
    required this.formKey,
    required this.autovalidateMode,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.joinDate,
    required this.status,
    required this.admin,
  });
  final Key formKey;
  final AutovalidateMode autovalidateMode;
  final ValueChanged<String?> imageUrl;
  final ValueChanged<String?> name;
  final ValueChanged<String?> type;
  final ValueChanged<String?> joinDate;
  final ValueChanged<String?> status;
  final ValueChanged<String?> admin;

  @override
  State<CustomBasicInfoStep> createState() => _CustomBasicInfoStepState();
}

class _CustomBasicInfoStepState extends State<CustomBasicInfoStep> {
  String? imageUrl;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController joinDateController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController adminController = TextEditingController();

  String selectedUserType = userTypes[3];
  String selectedUserStatus = userStatuses[0];
  String selectedAdmin = admin[1];

  @override
  void initState() {
    // joinDateController.text = DateTime.now().toString().substring(0, 10);
    final now = DateTime.now();
    joinDateController.text =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    typeController.text = selectedUserType;
    statusController.text = selectedUserStatus;
    adminController.text = selectedAdmin;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    joinDateController.dispose();
    statusController.dispose();
    adminController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        autovalidateMode: widget.autovalidateMode,
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomImagePicker(
              onFileChanged: (url) => imageUrl = url,
              auth: true,
              radius: 70,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              labels: "${S.of(context).employee_name} *",
              hintText: S.of(context).enter_employee_name,
              controller: nameController,
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'name',
                  max: 50,
                  min: 3,
                );
              },
              keyboardType: TextInputType.name,
              suffixIcon: const Icon(Icons.person_outline),
              onSaved: (value) {
                setState(() {
                  widget.name(value);
                });
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: "${S.of(context).employee_type} *",
              hintText: S.of(context).enter_employee_type,
              controller: typeController,
              onChanged: (value) {
                setState(() {
                  selectedUserType = value;
                });
              },
              onSaved: (value) {
                setState(() {
                  widget.type(value);
                });
              },
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'name',
                  max: 50,
                  min: 3,
                );
              },
              keyboardType: TextInputType.name,
              readOnly: true,
              suffixIcon: const Icon(Icons.work_outline),
              onTap: () async {
                final result = await showDialog<String>(
                  context: context,
                  builder:
                      (context) => CustomSelectDialog(
                        items: userTypes,
                        title: S.of(context).select_employee_type,
                      ),
                );
                if (result != null) {
                  setState(() {
                    selectedUserType = result;
                    typeController.text = result;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            CustomDatePickerField(
              label: "${S.of(context).join_date} *",
              hint: S.of(context).enter_join_date,
              controller: joinDateController,
              onSaved: (value) {
                setState(() {
                  widget.joinDate(value);
                });
              },
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'date',
                  max: 10,
                  min: 10,
                );
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: "${S.of(context).employee_status} *",
              hintText: S.of(context).enter_employee_status,
              controller: statusController,
              onSaved: (value) {
                setState(() {
                  widget.status(value);
                });
              },
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'name',
                  max: 20,
                  min: 3,
                );
              },
              keyboardType: TextInputType.name,
              suffixIcon:
                  statusController.text == 'Active'
                      ? const Icon(Icons.check_circle_outline)
                      : const Icon(Icons.cancel_outlined, color: Colors.red),
              readOnly: true,
              onTap: () async {
                final result = await showDialog<String>(
                  context: context,
                  builder:
                      (context) => CustomSelectDialog(
                        items: userStatuses,
                        title: S.of(context).select_employee_status,
                      ),
                );
                if (result != null) {
                  setState(() {
                    statusController.text = result;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: "${S.of(context).is_admin} *",
              hintText: S.of(context).enter_is_admin,
              controller: adminController,
              readOnly: true,
              onSaved: (value) {
                setState(() {
                  widget.admin(value);
                });
              },
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'name',
                  max: 20,
                  min: 3,
                );
              },
              keyboardType: TextInputType.name,
              suffixIcon: const Icon(Icons.admin_panel_settings_outlined),
              onTap: () async {
                final result = await showDialog<String>(
                  context: context,
                  builder:
                      (context) => CustomSelectDialog(
                        items: admin,
                        title: S.of(context).select_is_admin,
                      ),
                );
                if (result != null) {
                  setState(() {
                    adminController.text = result;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
