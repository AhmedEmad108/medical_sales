
import 'package:flutter/material.dart';
import 'package:medical_sales/core/utils/app_color.dart';
import 'package:medical_sales/core/utils/app_style.dart';
import 'package:medical_sales/core/utils/custom_appbar.dart';
import 'package:medical_sales/core/widgets/custom_button.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});
  static const routeName = '/termsAndConditionsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Terms & Conditions', icon: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Our Application!',
                style: AppStyle.styleBold30(),
              ),
              const SizedBox(height: 20),
              Text(
                '''
These terms and conditions outline the rules and regulations for the use of our app.

By accessing this app, we assume you accept these terms and conditions. Do not continue to use the app if you do not agree to all of the terms and conditions stated on this page.

- Usage: The app is intended for personal use only.
- Privacy: We are committed to protecting your privacy. Your data will be handled according to our privacy policy.
- Liability: We are not liable for any damages arising from the use of this app.
- Changes: We reserve the right to modify or update these terms and conditions at any time.
- Termination: We may terminate this app at any time without notice.

Thank you for using our app!''',
                style: AppStyle.styleSemiBold22().copyWith(
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 33),
              CustomButton(
                title: 'Agree & Continue',
                buttonColor: AppColor.primaryColor,
                textStyle: AppStyle.styleBold24().copyWith(
                  color: AppColor.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
