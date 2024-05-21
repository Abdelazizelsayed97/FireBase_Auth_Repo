import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class ConfirmPhoneNumber extends StatefulWidget {
  const ConfirmPhoneNumber({super.key});

  @override
  State<ConfirmPhoneNumber> createState() => _ConfirmPhoneNumberState();
}

class _ConfirmPhoneNumberState extends State<ConfirmPhoneNumber> {
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
      const fillColor = Color.fromRGBO(243, 246, 249, 0);
      const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

      final defaultPinTheme = PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
          fontSize: 22,
          color: Color.fromRGBO(30, 60, 87, 1),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderColor),
        ),
      );

      return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  controller: pinController,
                  focusNode: FocusNode(),
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  validator: (value) {
                    return value == '222222' ? null : 'Pin is incorrect';
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    // Handle pin completion
                  },
                  onChanged: (value) {
                    // Handle pin change
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                  length: 6, // Set the length to 6
                )),
            TextButton(
              onPressed: () {
                setState(() {
                  formKey.currentState!.validate();
                });
              },
              child: const Text('Validate'),
            ),
          ],
        ),
      );
    });
  }
}
