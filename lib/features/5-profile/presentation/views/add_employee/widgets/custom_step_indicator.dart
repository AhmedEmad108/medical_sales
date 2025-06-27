import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/generated/l10n.dart';

class CustomStepIndicator extends StatefulWidget {
  const CustomStepIndicator({super.key});

  @override
  State<CustomStepIndicator> createState() => _CustomStepIndicatorState();
}

class _CustomStepIndicatorState extends State<CustomStepIndicator> {
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
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
                        currentPage >= index
                            ? AppColor.primaryColor
                            : AppColor.grey,
                    border:
                        currentPage == index
                            ? Border.all(color: AppColor.primaryColor, width: 2)
                            : null,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: AppStyle.styleBold16().copyWith(
                        color:
                            currentPage >= index ? Colors.white : Colors.black,
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
                          currentPage >= index
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
}
