import 'package:auth_app_firebase/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/confirm_phone_number.dart';

class VerifyPhoneNumberPage extends StatelessWidget {
  final VoidCallback createAccount;

  const VerifyPhoneNumberPage({super.key, required this.createAccount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Verify your phone number"),
            verticalSpace(30),
            const Text("Enter the code sent to your phone"),
            verticalSpace(50),
            const ConfirmPhoneNumber()
          ],
        ),
      ),
    );
  }
}
