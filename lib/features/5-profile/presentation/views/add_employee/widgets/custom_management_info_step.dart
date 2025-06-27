import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/backend_endpoint.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/widgets/add_employee_view_body.dart';
import 'package:medical_sales/generated/l10n.dart';

class CustomManagementInfoStep extends StatefulWidget {
  const CustomManagementInfoStep({
    super.key,
    required this.formKey,
    required this.autovalidateMode,
    required this.directManager,
    required this.areaManager,
    required this.territory,
    required this.salary,
    required this.notes,
    required this.type,
  });

  final Key formKey;
  final AutovalidateMode autovalidateMode;
  final String type;
  final ValueChanged<String?> directManager;
  final ValueChanged<String?> areaManager;
  final ValueChanged<String?> territory;
  final ValueChanged<String?> salary;
  final ValueChanged<String?> notes;

  @override
  State<CustomManagementInfoStep> createState() =>
      _CustomManagementInfoStepState();
}

class _CustomManagementInfoStepState extends State<CustomManagementInfoStep> {
  final TextEditingController directManagerController = TextEditingController();
  final TextEditingController areaManagerController = TextEditingController();
  final TextEditingController territoryController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? selectedDirectManager;
  String? selectedAreaManager;
  List<Map<String, dynamic>> managers = [];

  @override
  void initState() {
    super.initState();
    fetchManagers();
  }

  Future<void> fetchManagers() async {
    // Fetch managers from Firestore
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance
            .collection(BackendEndpoint.userData)
            .where(
              'userType',
              whereIn: ['Area Manager', 'District Manager', 'Senior Manager'],
            )
            .get();

    setState(() {
      managers =
          querySnapshot.docs
              .map(
                (doc) => {
                  'id': doc.id,
                  'name': (doc.data() as Map<String, dynamic>)['name'] ?? '',
                  'userType':
                      (doc.data() as Map<String, dynamic>)['userType'] ?? '',
                },
              )
              .toList();
    });
  }

  @override
  void dispose() {
    directManagerController.dispose();
    areaManagerController.dispose();
    territoryController.dispose();
    salaryController.dispose();
    notesController.dispose();
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
            Visibility(
              visible:
                  widget.type == 'Medical Rep' ||
                  widget.type == 'Senior Manager' ||
                  widget.type == 'District Manager',
              child: const SizedBox(height: 16),
            ),
            Visibility(
              visible:
                  widget.type == 'Medical Rep' ||
                  widget.type == 'Senior Manager' ||
                  widget.type == 'District Manager',
              child: CustomTextField(
                labels: "${S.of(context).area_manager} *",
                hintText: S.of(context).enter_area_manager,
                controller: areaManagerController,
                readOnly: true,
                onSaved: (value) {
                  widget.areaManager(value);
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
                onTap: () async {
                  final result = await showDialog<String>(
                    context: context,
                    builder:
                        (context) => CustomSelectDialog(
                          items:
                              managers
                                  .where(
                                    (manager) =>
                                        manager['userType'] == 'Area Manager',
                                  )
                                  .map((manager) => manager['name'] as String)
                                  .toList()
                                  .cast<String>(),
                          title: S.of(context).select_area_manager,
                        ),
                  );
                  if (result != null) {
                    setState(() {
                      areaManagerController.text = result;
                    });
                  }
                },
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(Icons.person_outline),
              ),
            ),

            Visibility(
              visible:
                  widget.type == 'Medical Rep' ||
                  widget.type == 'Senior Manager',
              child: const SizedBox(height: 16),
            ),
            Visibility(
              visible:
                  widget.type == 'Medical Rep' ||
                  widget.type == 'Senior Manager',
              child: CustomTextField(
                labels: "${S.of(context).direct_manager} *",
                hintText: S.of(context).enter_direct_manager,
                controller: directManagerController,
                readOnly: true,
                onSaved: (value) {
                  widget.directManager(value);
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
                onTap: () async {
                  final result = await showDialog<String>(
                    context: context,
                    builder:
                        (context) => CustomSelectDialog(
                          items:
                              managers
                                  .where(
                                    (manager) =>
                                        manager['userType'] ==
                                            'District Manager' ||
                                        manager['userType'] == 'Senior Manager',
                                  )
                                  .map((manager) => manager['name'] as String)
                                  .toList()
                                  .cast<String>(),
                          title: S.of(context).select_direct_manager,
                        ),
                  );
                  if (result != null) {
                    setState(() {
                      directManagerController.text = result;
                    });
                  }
                },
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: "${S.of(context).territory} *",
              hintText: S.of(context).enter_territory,
              controller: territoryController,
              onSaved: (value) {
                widget.territory(value);
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
              suffixIcon: const Icon(Icons.location_on_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: S.of(context).employee_basic_salary,
              hintText: S.of(context).enter_employee_basic_salary,
              controller: salaryController,
              onSaved: (value) {
                widget.salary(value);
              },
              keyboardType: TextInputType.number,
              suffixIcon: const Icon(Icons.monetization_on_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: S.of(context).employee_notes,
              hintText: S.of(context).enter_employee_notes,
              controller: notesController,
              onSaved: (value) {
                widget.notes(value);
              },
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              suffixIcon: const Icon(Icons.notes_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
