import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.readOnly = false,
    this.labels,
    this.obscureText = false,
    this.expanded = false,
    this.isNember = false,
    this.prefixIcon,
    required this.keyboardType,
    this.onTap,
  });
  final bool expanded;
  final String hintText;
  final String? labels;
  final int? maxLines;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final bool? obscureText;
  final bool isNember;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      // isNember
      //     ? const TextInputType.numberWithOptions(decimal: true)
      //     : TextInputType.text,
      readOnly: readOnly!,
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      minLines: 1,
      maxLines: expanded == true ? 5 : 1,
      onTap: onTap,
      // maxLength: expanded == true ? 5 : 1,
      obscureText: obscureText!,
      // obscureText: obscureText == null || obscureText == false ? false : true,
      cursorColor: AppColor.primaryColor,
      decoration: InputDecoration(
        // labelStyle: const TextStyle(color: Color(0xff39A2DB)),
        label: Text(labels ?? ''),
        // labelText: labels,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall,

        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(
          AppColor.primaryColor,
          // readOnly == false ? AppColor.primaryColor : Colors.grey,
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color ?? Colors.grey),
    );
  }
}
