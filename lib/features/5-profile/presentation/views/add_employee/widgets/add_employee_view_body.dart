import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_sales/contants.dart';
import 'package:medical_sales/core/cubit/add_employee/add_employee_cubit.dart';
import 'package:medical_sales/core/helper_functions/valid_input.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_dialog.dart';
import 'package:medical_sales/core/utils/custom_password_text_field.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/widgets/custom_basic_info_step.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/widgets/custom_management_info_step.dart';
import 'package:medical_sales/features/5-profile/presentation/views/add_employee/widgets/custom_step_indicator.dart';
import 'package:medical_sales/features/auth/domain/entities/user_entity.dart';
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
  // final _nameController = TextEditingController();
  // final _typeController = TextEditingController();
  // final _joinDateController = TextEditingController();
  // final _statusController = TextEditingController();
  // final _adminController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _addressController = TextEditingController();
  // final _directManagerController = TextEditingController();
  // final _areaManagerController = TextEditingController();
  // final _territoryController = TextEditingController();
  // final _salaryController = TextEditingController();
  // final _notesController = TextEditingController();

  String? _password;
  String? _confirmPassword;
  String? _imageUrl;

  String? name,
      type,
      joinDate,
      employeeStatus,
      admin,
      directManager,
      areaManager,
      territory,
      basicSalary,
      notes;

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _addressController.dispose();
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
              child: CustomStepIndicator(),
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
                    CustomBasicInfoStep(
                      formKey: _formKeys[0],
                      autovalidateMode: _autovalidateMode,
                      imageUrl: (url) => _imageUrl = url,
                      name: (value) => name = value!,
                      type: (value) => type = value!,
                      joinDate: (value) => joinDate = value!,
                      status: (value) => employeeStatus = value!,
                      admin: (value) => admin = value!,
                    ),
                    CustomManagementInfoStep(
                      formKey: _formKeys[1],
                      autovalidateMode: _autovalidateMode,
                      type: type ?? '',
                      directManager: (value) => directManager = value!,
                      areaManager: (value) => areaManager = value!,
                      territory: (value) => territory = value!,
                      salary: (value) => basicSalary = value!,
                      notes: (value) => notes = value!,
                    ),
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

  Widget _buildContactInfoStep() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeys[2],
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
      context.read<AddEmployeeCubit>().addEmployee(
        user: UserEntity(
          uId: '',
          image: _imageUrl ?? imageProfile,
          name: name!,
          password: _password!,
          userType: type!,
          joiningDate: joinDate!,
          employeeStatus: employeeStatus!,
          admin: admin!,
          directManager: directManager,
          areaManager: areaManager,
          territory: territory!,
          email: _emailController.text,
          phone: _phoneController.text,
          nationalId: _nationalIdController.text,
          address: _addressController.text,
          basicSalary: basicSalary,
          notes: notes,
        ),
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}

class CustomSelectDialog extends StatelessWidget {
  final List<String> items;
  final String? title;

  const CustomSelectDialog({super.key, required this.items, this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ...items.map(
              (item) => ListTile(
                title: Text(item),
                onTap: () => Navigator.pop(context, item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   final List<String> items;
//   final String hintText;
//   final String? labels;
//   final String? value;
//   final void Function(String?)? onChanged;
//   final void Function(String?)? onSaved;
//   final String? Function(String?)? validator;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool readOnly;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       onChanged: readOnly ? null : onChanged,
//       onSaved: onSaved,
//       validator: validator,
//       decoration: InputDecoration(
//         label: Text(labels ?? ''),
//         suffixIcon: suffixIcon,
//         prefixIcon: prefixIcon,
//         hintText: hintText,
//         hintStyle: Theme.of(context).textTheme.bodySmall,
//         border: buildBorder(),
//         enabledBorder: buildBorder(),
//         focusedBorder: buildBorder(AppColor.primaryColor),
//         // نفس الديزاين بتاع CustomTextField بالظبط
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 16,
//         ),
//       ),
//       icon: const Icon(Icons.arrow_drop_down),
//       items:
//           items
//               .map(
//                 (item) =>
//                     DropdownMenuItem<String>(value: item, child: Text(item)),
//               )
//               .toList(),
//       onTap: onTap,
//       // لو حابب تمنع فتح الليسته في حالة الريدي فقط
//       // isExpanded: true,
//     );
//   }

//   OutlineInputBorder buildBorder([color]) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide(color: color ?? Colors.grey),
//     );
//   }
// }

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
