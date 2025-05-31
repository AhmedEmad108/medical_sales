import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/features/auth/presentation/views/terms_and_conditions_view.dart';
import 'package:medical_sales/features/auth/presentation/views/widgets/custom_check_box_state.dart';
import 'package:medical_sales/generated/l10n.dart';

class CustomTermsAndCondition extends StatefulWidget {
  const CustomTermsAndCondition({
    super.key,
    required this.onChanged,
  });
  final ValueChanged<bool> onChanged;

  @override
  State<CustomTermsAndCondition> createState() =>
      _CustomTermsAndConditionState();
}

class _CustomTermsAndConditionState extends State<CustomTermsAndCondition> {
  bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(
          onChecked: (value) {
            isTermsAccepted = value;
            widget.onChanged(value);
            setState(() {});
          },
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text.rich(TextSpan(children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                S.of(context).terms_and_condition1,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TermsAndConditionsView.routeName,
                  );
                },
                child: Text(
                  S.of(context).terms_and_condition2,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.primaryColor,
                      ),
                ),
              ),
            ),
          ])),
        ),
      ],
    );
  }
}
