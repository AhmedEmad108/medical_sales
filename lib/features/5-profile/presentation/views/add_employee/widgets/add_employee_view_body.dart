import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_date_picker_field.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/custom_password_text_field.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/core/widgets/custom_image_picker.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
import 'package:medical_sales/core/cubit/user/user_cubit.dart';
import 'package:medical_sales/generated/l10n.dart';

class AddEmployeeViewBody extends StatefulWidget {
  const AddEmployeeViewBody({super.key});

  @override
  State<AddEmployeeViewBody> createState() => _AddEmployeeViewBodyState();
}

class _AddEmployeeViewBodyState extends State<AddEmployeeViewBody> {
  final _pageController = PageController();
  final _formKeys = List.generate(3, (index) => GlobalKey<FormState>());
  var _currentPage = 0;
  var _autovalidateMode = AutovalidateMode.disabled;

  // Form Controllers
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _joinDateController = TextEditingController();
  final _statusController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _addressController = TextEditingController();
  final _directManagerController = TextEditingController();
  final _areaManagerController = TextEditingController();
  final _territoryController = TextEditingController();
  final _salaryController = TextEditingController();
  final _notesController = TextEditingController();

  String? _password;
  String? _confirmPassword;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _setDefaultDate();
  }

  void _setDefaultDate() {
    final now = DateTime.now();
    _joinDateController.text =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _typeController.dispose();
    _joinDateController.dispose();
    _statusController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _addressController.dispose();
    _directManagerController.dispose();
    _areaManagerController.dispose();
    _territoryController.dispose();
    _salaryController.dispose();
    _notesController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
              ),

              child: _buildStepIndicator(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                ),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: _handlePageChange,
                  children: [
                    _buildBasicInfoStep(),
                    _buildManagementInfoStep(),
                    _buildContactInfoStep(),
                  ],
                ),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage >= index
                            ? AppColor.primaryColor
                            : AppColor.grey,
                    border:
                        _currentPage == index
                            ? Border.all(color: AppColor.primaryColor, width: 2)
                            : null,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: AppStyle.styleBold16().copyWith(
                        color:
                            _currentPage >= index ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FittedBox(
                  child: Text(
                    _getStepTitle(index),
                    style: AppStyle.styleMedium15().copyWith(
                      color:
                          _currentPage >= index
                              ? AppColor.primaryColor
                              : AppColor.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return S.of(context).basic_info;
      case 1:
        return S.of(context).management_info;
      case 2:
        return S.of(context).contact_info;
      default:
        return '';
    }
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[0],
        autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomImagePicker(
              onFileChanged: (url) => _imageUrl = url,
              auth: true,
              radius: 70,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              labels: "${S.of(context).employee_name} *",
              hintText: S.of(context).enter_employee_name,
              controller: _nameController,
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
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: "${S.of(context).employee_type} *",
              hintText: S.of(context).enter_employee_type,
              controller: _typeController,
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
              onTap: () {
                FocusScope.of(context).unfocus();
                _selectEmployeeType();
              },
            ),
            const SizedBox(height: 16),
            CustomDatePickerField(
              label: "${S.of(context).join_date} *",
              hint: S.of(context).enter_join_date,
              controller: _joinDateController,
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
              controller: _statusController,
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
              suffixIcon: const Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoStep() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[1],
        autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomTextField(
              labels: S.of(context).employee_email,
              hintText: S.of(context).enter_employee_email,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: S.of(context).employee_phone,
              hintText: S.of(context).enter_employee_phone,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              suffixIcon: const Icon(Icons.phone_android_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: S.of(context).employee_national_id,
              hintText: S.of(context).enter_employee_national_id,
              controller: _nationalIdController,
              keyboardType: TextInputType.number,
              suffixIcon: const Icon(Icons.badge_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: S.of(context).employee_address,
              hintText: S.of(context).employee_enter_address,
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              suffixIcon: const Icon(Icons.location_on_outlined),
            ),
            const SizedBox(height: 16),
            CustomPasswordTextField(
              label: "${S.of(context).employee_password} *",
              hintText: S.of(context).enter_employee_password,
              onSaved: (value) => _password = value,
            ),
            const SizedBox(height: 16),
            CustomPasswordTextField(
              label: "${S.of(context).confirm_employee_password} *",
              hintText: S.of(context).enter_confirm_employee_password,
              onSaved: (value) => _confirmPassword = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementInfoStep() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[2],
        autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomTextField(
              labels: "${S.of(context).direct_manager} *",
              hintText: S.of(context).enter_direct_manager,
              controller: _directManagerController,
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
              suffixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: "${S.of(context).area_manager} *",
              hintText: S.of(context).enter_area_manager,
              controller: _areaManagerController,
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
              suffixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: "${S.of(context).territory} *",
              hintText: S.of(context).enter_territory,
              controller: _territoryController,
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
              labels: "${S.of(context).employee_basic_salary} *",
              hintText: S.of(context).enter_employee_basic_salary,
              controller: _salaryController,
              validator: (value) {
                return validInput(
                  context: context,
                  val: value!,
                  type: 'number',
                  max: 20,
                  min: 3,
                );
              },
              keyboardType: TextInputType.number,
              suffixIcon: const Icon(Icons.monetization_on_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labels: S.of(context).employee_notes,
              hintText: S.of(context).enter_employee_notes,
              controller: _notesController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              suffixIcon: const Icon(Icons.notes_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kHorizontalPadding,
      ),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: CustomButton(
                title: S.of(context).previous,
                buttonColor: AppColor.transparent,
                textStyle: AppStyle.styleBold24().copyWith(
                  color: AppColor.black,
                ),
                onTap: _previousPage,
              ),
            ),
          if (_currentPage > 0) const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              title:
                  _currentPage == 2
                      ? S.of(context).add_employee
                      : S.of(context).next,
              buttonColor: AppColor.primaryColor,
              textStyle: AppStyle.styleBold24().copyWith(color: Colors.white),
              onTap: _currentPage == 2 ? _submitForm : _nextPage,
            ),
          ),
        ],
      ),
    );
  }

  void _handlePageChange(int page) {
    setState(() {
      _currentPage = page;
      _autovalidateMode = AutovalidateMode.disabled;
    });
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    final currentFormState = _formKeys[_currentPage].currentState;
    if (currentFormState != null && currentFormState.validate()) {
      currentFormState.save();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // نعيد ضبط وضع التحقق التلقائي عند الانتقال للصفحة التالية
      setState(() {
        _autovalidateMode = AutovalidateMode.disabled;
      });
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
  // void _nextPage() {
  //   if (_formKeys[_currentPage].currentState?.validate() ?? false) {
  //     _formKeys[_currentPage].currentState?.save();
  //     _pageController.nextPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   } else {
  //     setState(() {
  //       _autovalidateMode = AutovalidateMode.always;
  //     });
  //   }
  // }

  void _submitForm() {
    final currentForm = _formKeys[_currentPage].currentState;
    if (currentForm?.validate() ?? false) {
      currentForm?.save();

      // Validate all forms
      bool isValid = true;
      for (var key in _formKeys) {
        final formState = key.currentState;
        if (formState != null) {
          isValid = formState.validate() && isValid;
          formState.save();
        }
      }

      if (!isValid) {
        // Find first invalid form and navigate to it
        for (int i = 0; i < _formKeys.length; i++) {
          if (!(_formKeys[i].currentState?.validate() ?? false)) {
            _pageController.animateToPage(
              i,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            break;
          }
        }
        return;
      }

      // Check password match
      if (_password != _confirmPassword) {
        customDialog(
          context,
          title: S.of(context).password_and_confirm_password_not_match,
        );
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        return;
      }

      // Submit form
      context.read<UserCubit>().signUp(
        user: UserEntity(
          uId: '',
          image: _imageUrl ?? '',
          name: _nameController.text,
          userType: _typeController.text,
          joiningDate: _joinDateController.text,
          directManager: _directManagerController.text,
          areaManager: _areaManagerController.text,
          territory: _territoryController.text,
          employeeStatus: _statusController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          nationalId: _nationalIdController.text,
          address: _addressController.text,
          basicSalary: _salaryController.text,
          notes: _notesController.text,
        ),
        password: _password!,
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void _selectEmployeeType() {
    // This function should open a dialog or bottom sheet to select employee type
    // For now, we will just show a placeholder dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).select_employee_type),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: Text(S.of(context).medical_representative),
                  onTap: () {
                    _typeController.text = S.of(context).medical_representative;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(S.of(context).administator),
                  onTap: () {
                    _typeController.text = S.of(context).administator;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class FormStep extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final AutovalidateMode autovalidateMode;
//   final List<Widget> children;

//   const FormStep({
//     super.key,
//     required this.formKey,
//     required this.autovalidateMode,
//     required this.children,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       autovalidateMode: autovalidateMode,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//           child: Column(children: children),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_sales/contants.dart';
// import 'package:medical_sales/core/cubit/user/user_cubit.dart';
// import 'package:medical_sales/core/helper_functions/valid_input.dart';
// import 'package:medical_sales/core/utils/app_color.dart';
// import 'package:medical_sales/core/utils/app_style.dart';
// import 'package:medical_sales/core/utils/custom_dialog.dart';
// import 'package:medical_sales/core/utils/custom_password_text_field.dart';
// import 'package:medical_sales/core/widgets/custom_button.dart';
// import 'package:medical_sales/core/widgets/custom_image_picker.dart';
// import 'package:medical_sales/core/widgets/custom_text_field.dart';
// import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
// import 'package:medical_sales/generated/l10n.dart';

// class AddEmployeeViewBody extends StatefulWidget {
//   const AddEmployeeViewBody({super.key});

//   @override
//   State<AddEmployeeViewBody> createState() => _AddEmployeeViewBodyState();
// }

// class _AddEmployeeViewBodyState extends State<AddEmployeeViewBody> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

//   TextEditingController emoloyeeNameController = TextEditingController();
//   TextEditingController employeeTypeController = TextEditingController();
//   TextEditingController joinDateController = TextEditingController();
//   TextEditingController directManagerController = TextEditingController();
//   TextEditingController areaManagerController = TextEditingController();
//   TextEditingController territoryController = TextEditingController();
//   TextEditingController emoloyeeStatusController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController nationalIdController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController basicSalaryController = TextEditingController();
//   TextEditingController notesController = TextEditingController();

//   String? password;
//   String? confirmPassword;
//   String? urlImage;

//   @override
//   void initState() {
//     super.initState();
//     // Set default join date to current date
//     joinDateController.text = DateTime.now().toString().substring(0, 10);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     emoloyeeNameController.dispose();
//     employeeTypeController.dispose();
//     joinDateController.dispose();
//     directManagerController.dispose();
//     areaManagerController.dispose();
//     territoryController.dispose();
//     emoloyeeStatusController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     nationalIdController.dispose();
//     addressController.dispose();
//     basicSalaryController.dispose();
//     notesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//       child: Form(
//         key: formKey,
//         autovalidateMode: autoValidateMode,
//         child: Column(
//           children: [
//             // Step Indicator
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildStepIndicator(0, S.of(context).basic_info),
//                   _buildStepLine(),
//                   _buildStepIndicator(1, S.of(context).contact_info),
//                   _buildStepLine(),
//                   _buildStepIndicator(2, S.of(context).management_info),
//                 ],
//               ),
//             ),

//             // Pages
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentPage = index;
//                   });
//                 },
//                 children: [
//                   SingleChildScrollView(child: _buildBasicInfoStep()),
//                   SingleChildScrollView(child: _buildContactInfoStep()),
//                   SingleChildScrollView(child: _buildManagementInfoStep()),
//                 ],
//               ),
//             ),

//             // Navigation Buttons
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 if (_currentPage > 0)
//                   Expanded(
//                     child: CustomButton(
//                       title: S.of(context).previous,
//                       buttonColor: AppColor.grey,
//                       textStyle: AppStyle.styleBold16().copyWith(
//                         color: AppColor.white,
//                       ),
//                       onTap: () {
//                         _pageController.previousPage(
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         );
//                       },
//                     ),
//                   ),
//                 if (_currentPage > 0) const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomButton(
//                     title:
//                         _currentPage == 2
//                             ? S.of(context).add_employee
//                             : S.of(context).next,
//                     buttonColor: AppColor.primaryColor,
//                     textStyle: AppStyle.styleBold16().copyWith(
//                       color: AppColor.white,
//                     ),
//                     onTap: () {
//                       if (_currentPage < 2) {
//                         if (_validateCurrentStep()) {
//                           _pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           );
//                         }
//                       } else {
//                         _submitForm();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   bool _validateCurrentStep() {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();

//       switch (_currentPage) {
//         case 0:
//           // التحقق من البيانات الأساسية
//           if (emoloyeeNameController.text.isEmpty ||
//               employeeTypeController.text.isEmpty ||
//               joinDateController.text.isEmpty ||
//               emoloyeeStatusController.text.isEmpty) {
//             customDialog(
//               context,
//               title: 'S.of(context).please_fill_all_required_fields',
//             );
//             setState(() {
//               autoValidateMode = AutovalidateMode.always;
//             });
//             return false;
//           }
//           return true;

//         case 1:
//           // التحقق من بيانات الاتصال والباسورد
//           if (emailController.text.isEmpty ||
//               phoneController.text.isEmpty ||
//               nationalIdController.text.isEmpty ||
//               password == null ||
//               confirmPassword == null) {
//             customDialog(
//               context,
//               title: 'S.of(context).please_fill_all_required_fields',
//             );
//             setState(() {
//               autoValidateMode = AutovalidateMode.always;
//             });
//             return false;
//           }

//           // التحقق من تطابق كلمة المرور
//           if (password != confirmPassword) {
//             customDialog(
//               context,
//               title: S.of(context).password_and_confirm_password_not_match,
//             );
//             return false;
//           }
//           return true;

//         default:
//           return true;
//       }
//     } else {
//       setState(() {
//         autoValidateMode = AutovalidateMode.always;
//       });
//       return false;
//     }
//   }

//   Widget _buildStepIndicator(int step, String title) {
//     bool isActive = _currentPage >= step;
//     bool isCurrent = _currentPage == step;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: isActive ? AppColor.primaryColor : AppColor.grey,
//             border:
//                 isCurrent
//                     ? Border.all(color: AppColor.primaryColor, width: 2)
//                     : null,
//           ),
//           child: Center(
//             child: Text(
//               '${step + 1}',
//               style: AppStyle.styleBold16().copyWith(
//                 color: isActive ? AppColor.white : AppColor.black,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           title,
//           style: AppStyle.styleMedium15().copyWith(
//             color: isActive ? AppColor.primaryColor : AppColor.grey,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStepLine() {
//     return Expanded(
//       child: Container(
//         height: 2,
//         color: AppColor.grey,
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//       ),
//     );
//   }

//   Widget _buildBasicInfoStep() {
//     return Column(
//       children: [
//         CustomImagePicker(
//           onFileChanged: (url) => urlImage = url,
//           auth: true,
//           radius: 70,
//         ),
//         const SizedBox(height: 33),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_name,
//           labels: S.of(context).employee_name,
//           controller: emoloyeeNameController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_type,
//           labels: S.of(context).employee_type,
//           controller: employeeTypeController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.work_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_join_date,
//           labels: S.of(context).join_date,
//           controller: joinDateController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'date',
//               max: 10,
//               min: 10,
//             );
//           },
//           keyboardType: TextInputType.datetime,
//           suffixIcon: const Icon(Icons.date_range_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_status,
//           labels: S.of(context).employee_status,
//           controller: emoloyeeStatusController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//       ],
//     );
//   }

//   Widget _buildContactInfoStep() {
//     return Column(
//       children: [
//         CustomTextField(
//           hintText: S.of(context).enter_employee_email,
//           labels: S.of(context).employee_email,
//           controller: emailController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'email',
//               max: 50,
//               min: 5,
//             );
//           },
//           keyboardType: TextInputType.emailAddress,
//           suffixIcon: const Icon(Icons.email_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_phone,
//           labels: S.of(context).employee_phone,
//           controller: phoneController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'phone',
//               max: 11,
//               min: 11,
//             );
//           },
//           keyboardType: TextInputType.phone,
//           suffixIcon: const Icon(Icons.phone_android_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_national_id,
//           labels: S.of(context).employee_national_id,
//           controller: nationalIdController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'nationalId',
//               max: 14,
//               min: 14,
//             );
//           },
//           keyboardType: TextInputType.number,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).employee_enter_address,
//           labels: S.of(context).employee_address,
//           controller: addressController,
//           keyboardType: TextInputType.streetAddress,
//           suffixIcon: const Icon(Icons.location_on_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomPasswordTextField(
//           label: S.of(context).employee_password,
//           hintText: S.of(context).enter_employee_password,
//           onSaved: (value) {
//             password = value;
//           },
//           // v: (value) {
//           //   return validInput(
//           //     context: context,
//           //     val: value!,
//           //     type: 'password',
//           //     max: 30,
//           //     min: 6,
//           //   );
//           // },
//         ),
//         const SizedBox(height: 16),
//         CustomPasswordTextField(
//           label: S.of(context).confirm_employee_password,
//           hintText: S.of(context).enter_confirm_employee_password,
//           onSaved: (value) {
//             confirmPassword = value;
//           },
//           // validator: (value) {
//           //   return validInput(
//           //     context: context,
//           //     val: value!,
//           //     type: 'password',
//           //     max: 30,
//           //     min: 6,
//           //   );
//           // },
//         ),
//       ],
//     );
//   }

//   Widget _buildManagementInfoStep() {
//     return Column(
//       children: [
//         CustomTextField(
//           hintText: S.of(context).enter_direct_manager,
//           labels: S.of(context).direct_manager,
//           controller: directManagerController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_area_manager,
//           labels: S.of(context).area_manager,
//           controller: areaManagerController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_territory,
//           labels: S.of(context).territory,
//           controller: territoryController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.location_on_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_basic_salary,
//           labels: S.of(context).employee_basic_salary,
//           controller: basicSalaryController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'number',
//               max: 10,
//               min: 1,
//             );
//           },
//           keyboardType: TextInputType.number,
//           suffixIcon: const Icon(Icons.monetization_on_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_notes,
//           labels: S.of(context).employee_notes,
//           controller: notesController,
//           keyboardType: TextInputType.multiline,
//           maxlines: 3,
//           suffixIcon: const Icon(Icons.notes_outlined),
//         ),
//       ],
//     );
//   }

//   void _submitForm() {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();
//       if (password == confirmPassword) {
//         context.read<UserCubit>().signUp(
//           user: UserEntity(
//             uId: '',
//             image: urlImage ?? '',
//             name: emoloyeeNameController.text,
//             userType: employeeTypeController.text,
//             joiningDate: joinDateController.text,
//             directManager: directManagerController.text,
//             areaManager: areaManagerController.text,
//             territory: territoryController.text,
//             employeeStatus: emoloyeeStatusController.text,
//             email: emailController.text,
//             phone: phoneController.text,
//             nationalId: nationalIdController.text,
//             address: addressController.text,
//             basicSalary: basicSalaryController.text,
//             notes: notesController.text,
//           ),
//           password: password!,
//         );
//       } else {
//         customDialog(
//           context,
//           title: S.of(context).password_and_confirm_password_not_match,
//         );
//       }
//     } else {
//       setState(() {
//         autoValidateMode = AutovalidateMode.always;
//       });
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_sales/contants.dart';
// import 'package:medical_sales/core/cubit/user/user_cubit.dart';
// import 'package:medical_sales/core/helper_functions/valid_input.dart';
// import 'package:medical_sales/core/utils/app_color.dart';
// import 'package:medical_sales/core/utils/app_style.dart';
// import 'package:medical_sales/core/utils/custom_dialog.dart';
// import 'package:medical_sales/core/utils/custom_password_text_field.dart';
// import 'package:medical_sales/core/widgets/custom_button.dart';
// import 'package:medical_sales/core/widgets/custom_image_picker.dart';
// import 'package:medical_sales/core/widgets/custom_text_field.dart';
// import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
// import 'package:medical_sales/generated/l10n.dart';

// class AddEmployeeViewBody extends StatefulWidget {
//   const AddEmployeeViewBody({super.key});

//   @override
//   State<AddEmployeeViewBody> createState() => _AddEmployeeViewBodyState();
// }

// class _AddEmployeeViewBodyState extends State<AddEmployeeViewBody> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

//   TextEditingController emoloyeeNameController = TextEditingController();
//   TextEditingController employeeTypeController = TextEditingController();
//   TextEditingController joinDateController = TextEditingController();
//   TextEditingController directManagerController = TextEditingController();
//   TextEditingController areaManagerController = TextEditingController();
//   TextEditingController territoryController = TextEditingController();
//   TextEditingController emoloyeeStatusController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController nationalIdController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController basicSalaryController = TextEditingController();
//   TextEditingController notesController = TextEditingController();

//   String? password;
//   String? confirmPassword;
//   String? urlImage;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     emoloyeeNameController.dispose();
//     employeeTypeController.dispose();
//     joinDateController.dispose();
//     directManagerController.dispose();
//     areaManagerController.dispose();
//     territoryController.dispose();
//     emoloyeeStatusController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     nationalIdController.dispose();
//     addressController.dispose();
//     basicSalaryController.dispose();
//     notesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//       child: Form(
//         key: formKey,
//         autovalidateMode: autoValidateMode,
//         child: Column(
//           children: [
//             // Step Indicator
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildStepIndicator(0, S.of(context).basic_info),
//                   _buildStepLine(),
//                   _buildStepIndicator(1, S.of(context).contact_info),
//                   _buildStepLine(),
//                   _buildStepIndicator(2, S.of(context).management_info),
//                 ],
//               ),
//             ),

//             // Pages
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentPage = index;
//                   });
//                 },
//                 children: [
//                   SingleChildScrollView(child: _buildBasicInfoStep()),
//                   SingleChildScrollView(child: _buildContactInfoStep()),
//                   SingleChildScrollView(child: _buildManagementInfoStep()),
//                 ],
//               ),
//             ),

//             // Navigation Buttons
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 if (_currentPage > 0)
//                   Expanded(
//                     child: CustomButton(
//                       title: S.of(context).previous,
//                       buttonColor: AppColor.grey,
//                       textStyle: AppStyle.styleBold16().copyWith(
//                         color: AppColor.white,
//                       ),
//                       onTap: () {
//                         _pageController.previousPage(
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         );
//                       },
//                     ),
//                   ),
//                 if (_currentPage > 0) const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomButton(
//                     title:
//                         _currentPage == 2
//                             ? S.of(context).add_employee
//                             : S.of(context).next,
//                     buttonColor: AppColor.primaryColor,
//                     textStyle: AppStyle.styleBold16().copyWith(
//                       color: AppColor.white,
//                     ),
//                     onTap: () {
//                       if (_currentPage < 2) {
//                         _pageController.nextPage(
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         );
//                       } else {
//                         _submitForm();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStepIndicator(int step, String title) {
//     bool isActive = _currentPage >= step;
//     bool isCurrent = _currentPage == step;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: isActive ? AppColor.primaryColor : AppColor.grey,
//             border:
//                 isCurrent
//                     ? Border.all(color: AppColor.primaryColor, width: 2)
//                     : null,
//           ),
//           child: Center(
//             child: Text(
//               '${step + 1}',
//               style: AppStyle.styleBold16().copyWith(
//                 color: isActive ? AppColor.white : AppColor.black,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           title,
//           style: AppStyle.styleMedium15().copyWith(
//             color: isActive ? AppColor.primaryColor : AppColor.grey,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStepLine() {
//     return Expanded(
//       child: Container(
//         height: 2,
//         color: AppColor.grey,
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//       ),
//     );
//   }

//   Widget _buildBasicInfoStep() {
//     return Column(
//       children: [
//         CustomImagePicker(
//           onFileChanged: (url) => urlImage = url,
//           auth: true,
//           radius: 70,
//         ),
//         const SizedBox(height: 33),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_name,
//           labels: S.of(context).employee_name,
//           controller: emoloyeeNameController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_type,
//           labels: S.of(context).employee_type,
//           controller: employeeTypeController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.work_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_join_date,
//           labels: S.of(context).join_date,
//           controller: joinDateController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'date',
//               max: 10,
//               min: 10,
//             );
//           },
//           keyboardType: TextInputType.datetime,
//           suffixIcon: const Icon(Icons.date_range_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_status,
//           labels: S.of(context).employee_status,
//           controller: emoloyeeStatusController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//       ],
//     );
//   }

//   Widget _buildContactInfoStep() {
//     return Column(
//       children: [
//         CustomTextField(
//           hintText: S.of(context).enter_employee_email,
//           labels: S.of(context).employee_email,
//           controller: emailController,
//           keyboardType: TextInputType.emailAddress,
//           suffixIcon: const Icon(Icons.email_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_phone,
//           labels: S.of(context).employee_phone,
//           controller: phoneController,
//           keyboardType: TextInputType.phone,
//           suffixIcon: const Icon(Icons.phone_android_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_national_id,
//           labels: S.of(context).employee_national_id,
//           controller: nationalIdController,
//           keyboardType: TextInputType.number,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).employee_enter_address,
//           labels: S.of(context).employee_address,
//           controller: addressController,
//           keyboardType: TextInputType.streetAddress,
//           suffixIcon: const Icon(Icons.location_on_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomPasswordTextField(
//           label: S.of(context).employee_password,
//           hintText: S.of(context).enter_employee_password,
//           onSaved: (value) {
//             password = value;
//           },
//         ),
//         const SizedBox(height: 16),
//         CustomPasswordTextField(
//           label: S.of(context).confirm_employee_password,
//           hintText: S.of(context).enter_confirm_employee_password,
//           onSaved: (value) {
//             confirmPassword = value;
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildManagementInfoStep() {
//     return Column(
//       children: [
//         CustomTextField(
//           hintText: S.of(context).enter_direct_manager,
//           labels: S.of(context).direct_manager,
//           controller: directManagerController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_area_manager,
//           labels: S.of(context).area_manager,
//           controller: areaManagerController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_territory,
//           labels: S.of(context).territory,
//           controller: territoryController,
//           validator: (value) {
//             return validInput(
//               context: context,
//               val: value!,
//               type: 'name',
//               max: 20,
//               min: 3,
//             );
//           },
//           keyboardType: TextInputType.name,
//           suffixIcon: const Icon(Icons.location_on_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_basic_salary,
//           labels: S.of(context).employee_basic_salary,
//           controller: basicSalaryController,
//           keyboardType: TextInputType.number,
//           suffixIcon: const Icon(Icons.monetization_on_outlined),
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           hintText: S.of(context).enter_employee_notes,
//           labels: S.of(context).employee_notes,
//           controller: notesController,
//           keyboardType: TextInputType.multiline,
//           maxlines: 3,
//           suffixIcon: const Icon(Icons.notes_outlined),
//         ),
//       ],
//     );
//   }

//   void _submitForm() {
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();
//       if (password == confirmPassword) {
//         context.read<UserCubit>().signUp(
//           user: UserEntity(
//             uId: '',
//             image: urlImage ?? '',
//             name: emoloyeeNameController.text,
//             userType: employeeTypeController.text,
//             joiningDate: joinDateController.text,
//             directManager: directManagerController.text,
//             areaManager: areaManagerController.text,
//             territory: territoryController.text,
//             employeeStatus: emoloyeeStatusController.text,
//             email: emailController.text,
//             phone: phoneController.text,
//             nationalId: nationalIdController.text,
//             address: addressController.text,
//             basicSalary: basicSalaryController.text,
//             notes: notesController.text,
//           ),
//           password: password!,
//         );
//       } else {
//         customDialog(
//           context,
//           title: S.of(context).password_and_confirm_password_not_match,
//         );
//       }
//     } else {
//       setState(() {
//         autoValidateMode = AutovalidateMode.always;
//       });
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_sales/contants.dart';
// import 'package:medical_sales/core/cubit/user/user_cubit.dart';
// import 'package:medical_sales/core/helper_functions/valid_input.dart';
// import 'package:medical_sales/core/utils/app_color.dart';
// import 'package:medical_sales/core/utils/app_style.dart';
// import 'package:medical_sales/core/utils/custom_dialog.dart';
// import 'package:medical_sales/core/utils/custom_password_text_field.dart';
// import 'package:medical_sales/core/widgets/custom_button.dart';
// import 'package:medical_sales/core/widgets/custom_image_picker.dart';
// import 'package:medical_sales/core/widgets/custom_text_field.dart';
// import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
// import 'package:medical_sales/generated/l10n.dart';

// class AddEmployeeViewBody extends StatefulWidget {
//   const AddEmployeeViewBody({super.key});

//   @override
//   State<AddEmployeeViewBody> createState() => _AddEmployeeViewBodyState();
// }

// class _AddEmployeeViewBodyState extends State<AddEmployeeViewBody> {
//   late bool isTermsAccepted = false;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
//   TextEditingController emoloyeeNameController = TextEditingController();
//   TextEditingController employeeTypeController = TextEditingController();
//   TextEditingController joinDateController = TextEditingController();
//   TextEditingController directManagerController = TextEditingController();
//   TextEditingController areaManagerController = TextEditingController();
//   TextEditingController territoryController = TextEditingController();
//   TextEditingController emoloyeeStatusController = TextEditingController();

//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController nationalIdController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController basicSalaryController = TextEditingController();
//   TextEditingController notesController = TextEditingController();

//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   late String emoloyeeName,
//       employeeType,
//       joinDate,
//       directManager,
//       areaManager,
//       territory,
//       emoloyeeStatus,
//       email,
//       phone,
//       nationalId,
//       address,
//       basicSalary,
//       notes,
//       password,
//       confirmPassword;
//   String? urlImage;

//   @override
//   void dispose() {
//     emoloyeeNameController.dispose();
//     employeeTypeController.dispose();
//     joinDateController.dispose();
//     directManagerController.dispose();
//     areaManagerController.dispose();
//     territoryController.dispose();
//     emoloyeeStatusController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     nationalIdController.dispose();
//     addressController.dispose();
//     basicSalaryController.dispose();
//     notesController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//         child: Form(
//           key: formKey,
//           autovalidateMode: autoValidateMode,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               CustomImagePicker(
//                 onFileChanged: (url) => urlImage = url,
//                 auth: true,
//                 radius: 70,
//               ),
//               const SizedBox(height: 33),
//               CustomTextField(
//                 hintText: S.of(context).enter_employee_name,
//                 labels: S.of(context).employee_name,
//                 controller: emoloyeeNameController,
//                 validator: (value) {
//                   return validInput(
//                     context: context,
//                     val: value!,
//                     type: 'name',
//                     max: 20,
//                     min: 3,
//                   );
//                 },
//                 keyboardType: TextInputType.name,
//                 suffixIcon: const Icon(Icons.person_outline),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_employee_type,
//                 labels: S.of(context).employee_type,
//                 controller: employeeTypeController,
//                 validator: (value) {
//                   return validInput(
//                     context: context,
//                     val: value!,
//                     type: 'name',
//                     max: 20,
//                     min: 3,
//                   );
//                 },
//                 keyboardType: TextInputType.name,
//                 suffixIcon: const Icon(Icons.work_outline),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_join_date,
//                 labels: S.of(context).join_date,
//                 controller: joinDateController,
//                 validator: (value) {
//                   return validInput(
//                     context: context,
//                     val: value!,
//                     type: 'date',
//                     max: 10,
//                     min: 10,
//                   );
//                 },
//                 keyboardType: TextInputType.datetime,
//                 suffixIcon: const Icon(Icons.date_range_outlined),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_direct_manager,
//                 labels: S.of(context).direct_manager,
//                 controller: directManagerController,
//                 validator: (value) {
//                   return validInput(
//                     context: context,
//                     val: value!,
//                     type: 'name',
//                     max: 20,
//                     min: 3,
//                   );
//                 },
//                 keyboardType: TextInputType.name,
//                 suffixIcon: const Icon(Icons.person_outline),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_area_manager,
//                 labels: S.of(context).area_manager,
//                 controller: areaManagerController,
//                 validator: (value) {
//                   return validInput(
//                     context: context,
//                     val: value!,
//                     type: 'name',
//                     max: 20,
//                     min: 3,
//                   );
//                 },
//                 keyboardType: TextInputType.name,
//                 suffixIcon: const Icon(Icons.person_outline),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_territory,
//                 labels: S.of(context).territory,
//                 controller: territoryController,
//                 validator: (value) {
//                   return validInput(
//                     context: context,
//                     val: value!,
//                     type: 'name',
//                     max: 20,
//                     min: 3,
//                   );
//                 },
//                 keyboardType: TextInputType.name,
//                 suffixIcon: const Icon(Icons.location_on_outlined),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_employee_status,
//                 labels: S.of(context).employee_status,
//                 controller: emoloyeeStatusController,
//                 validator: (value) {
//                   return validInput(
//                     context: context,
//                     val: value!,
//                     type: 'name',
//                     max: 20,
//                     min: 3,
//                   );
//                 },
//                 keyboardType: TextInputType.name,
//                 suffixIcon: const Icon(Icons.person_outline),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_employee_email,
//                 labels: S.of(context).employee_email,
//                 controller: emailController,
//                 // validator: (value) {
//                 //   return validInput(
//                 //     context: context,
//                 //     val: value!,
//                 //     type: 'email',
//                 //     max: 30,
//                 //     min: 10,
//                 //   );
//                 // },
//                 keyboardType: TextInputType.emailAddress,
//                 suffixIcon: const Icon(Icons.email_outlined),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_employee_phone,
//                 labels: S.of(context).employee_phone,
//                 controller: phoneController,
//                 // validator: (value) {
//                 //   return validInput(
//                 //     context: context,
//                 //     val: value!,
//                 //     type: 'phone',
//                 //     max: 30,
//                 //     min: 9,
//                 //   );
//                 // },
//                 keyboardType: TextInputType.phone,
//                 suffixIcon: const Icon(Icons.phone_android_outlined),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_employee_national_id,
//                 labels: S.of(context).employee_national_id,
//                 controller: nationalIdController,
//                 // validator: (value) {
//                 //   return validInput(
//                 //     context: context,
//                 //     val: value!,
//                 //     type: 'nationalId',
//                 //     max: 14,
//                 //     min: 14,
//                 //   );
//                 // },
//                 keyboardType: TextInputType.number,
//                 suffixIcon: const Icon(Icons.person_outline),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).employee_enter_address,
//                 labels: S.of(context).employee_address,
//                 controller: addressController,
//                 // validator: (value) {
//                 //   return validInput(
//                 //     context: context,
//                 //     val: value!,
//                 //     type: 'name',
//                 //     max: 20,
//                 //     min: 3,
//                 //   );
//                 // },
//                 keyboardType: TextInputType.name,
//                 suffixIcon: const Icon(Icons.location_on_outlined),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_employee_basic_salary,
//                 labels: S.of(context).employee_basic_salary,
//                 controller: basicSalaryController,
//                 // validator: (value) {
//                 //   return validInput(
//                 //     context: context,
//                 //     val: value!,
//                 //     type: 'salary',
//                 //     max: 10,
//                 //     min: 1,
//                 //   );
//                 // },
//                 keyboardType: TextInputType.number,
//                 suffixIcon: const Icon(Icons.monetization_on_outlined),
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hintText: S.of(context).enter_employee_notes,
//                 labels: S.of(context).employee_notes,
//                 controller: notesController,
//                 // validator: (value) {
//                 //   return validInput(
//                 //     context: context,
//                 //     val: value!,
//                 //     type: 'name',
//                 //     max: 100,
//                 //     min: 3,
//                 //   );
//                 // },
//                 keyboardType: TextInputType.name,
//                 suffixIcon: const Icon(Icons.notes_outlined),
//               ),
//               const SizedBox(height: 16),
//               CustomPasswordTextField(
//                 label: S.of(context).employee_password,
//                 // controller: passwordController,
//                 hintText: S.of(context).enter_employee_password,
//                 onSaved: (value) {
//                   password = value!;
//                 },
//               ),
//               const SizedBox(height: 16),
//               CustomPasswordTextField(
//                 label: S.of(context).confirm_employee_password,
//                 // controller: confirmPasswordController,
//                 hintText: S.of(context).enter_confirm_employee_password,
//                 onSaved: (value) {
//                   confirmPassword = value!;
//                 },
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 title: S.of(context).add_employee,
//                 buttonColor: AppColor.primaryColor,
//                 textStyle: AppStyle.styleBold24().copyWith(
//                   color: AppColor.white,
//                 ),
//                 onTap: () async {
//                   if (formKey.currentState!.validate()) {
//                     formKey.currentState!.save();
//                     if (password == confirmPassword) {
//                       context.read<UserCubit>().signUp(
//                         user: UserEntity(
//                           uId: '',
//                           image: urlImage ?? '',
//                           name: emoloyeeNameController.text,
//                           userType: employeeTypeController.text,
//                           joiningDate: joinDateController.text,
//                           directManager: directManagerController.text,
//                           areaManager: areaManagerController.text,
//                           territory: territoryController.text,
//                           employeeStatus: emoloyeeStatusController.text,
//                           email: emailController.text,
//                           phone: phoneController.text,
//                           nationalId: nationalIdController.text,
//                           address: addressController.text,
//                           basicSalary: basicSalaryController.text,
//                           notes: notesController.text,
//                         ),
//                         password: password,
//                       );
//                     } else {
//                       customDialog(
//                         context,
//                         title:
//                             S
//                                 .of(context)
//                                 .password_and_confirm_password_not_match,
//                       );
//                     }
//                   } else {
//                     autoValidateMode = AutovalidateMode.always;
//                     setState(() {});
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
