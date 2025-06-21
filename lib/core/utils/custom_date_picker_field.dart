import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/widgets/custom_text_field.dart';

class CustomDatePickerField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool showTimePicker;
  final String? dateFormat;
  final bool readOnly;
  final Function(DateTime)? onDateSelected;

  const CustomDatePickerField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.showTimePicker = false,
    this.dateFormat,
    this.readOnly = false,
    this.onDateSelected,
  });

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  late DateTime _selectedDate;
  late TimeOfDay? _selectedTime;
  final _dateFormat = DateFormat('yyyy-MM-dd');
  final _timeFormat = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    _initializeDateTime();
  }

  void _initializeDateTime() {
    if (widget.controller.text.isNotEmpty) {
      try {
        _selectedDate = _dateFormat.parse(widget.controller.text);
        if (widget.showTimePicker && widget.controller.text.contains(' ')) {
          final timeStr = widget.controller.text.split(' ')[1];
          final time = _timeFormat.parse(timeStr);
          _selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);
        }
      } catch (e) {
        _selectedDate = DateTime.now();
        _selectedTime = widget.showTimePicker ? TimeOfDay.now() : null;
      }
    } else {
      _selectedDate = DateTime.now();
      _selectedTime = widget.showTimePicker ? TimeOfDay.now() : null;
    }
    _updateControllerText();
  }

  void _updateControllerText() {
    if (widget.showTimePicker && _selectedTime != null) {
      final dateTimeStr =
          '${_dateFormat.format(_selectedDate)} '
          '${_selectedTime!.hour.toString().padLeft(2, '0')}:'
          '${_selectedTime!.minute.toString().padLeft(2, '0')}';
      widget.controller.text = dateTimeStr;
    } else {
      widget.controller.text = _dateFormat.format(_selectedDate);
    }
  }

  Future<void> _selectDate() async {
    if (widget.readOnly) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? _selectedDate,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor,
              onPrimary: AppColor.white,
              surface: AppColor.white,
              onSurface: AppColor.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(picked);
        }
      });

      if (widget.showTimePicker) {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: _selectedTime ?? TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColor.primaryColor,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColor.primaryColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        if (time != null) {
          setState(() {
            _selectedTime = time;
          });
        }
      }

      _updateControllerText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: widget.hint,
      labels: widget.label,
      keyboardType: TextInputType.none,
      controller: widget.controller,
      validator: widget.validator,
      readOnly: true,
      onTap: _selectDate,
      suffixIcon: const Icon(Icons.calendar_month_outlined),
    );
  }
}
