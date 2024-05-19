import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.textHint,
    this.icon,
    this.opsCureText,
    this.suffixIcon,
    required this.controller,
    this.validator,
    this.label,
    this.onChanged,
    this.maxLines,
  });

  final TextEditingController controller;
  final String? label;
  final String? textHint;
  final Widget? icon;
  final bool? opsCureText;
  final Widget? suffixIcon;
  final Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;

  @override
  Widget build(BuildContext context) => TextFormField(
        onChanged: onChanged,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        autofocus: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: opsCureText ?? false,
        maxLines: maxLines,
        inputFormatters: [NoLeadingSpaceFormatter()],
        decoration: InputDecoration(
            label: Text(label ?? ''),
            suffixIcon: suffixIcon,
            fillColor: Colors.white,
            filled: true,
            enabled: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.grey)),
            hintText: textHint,
            prefixIcon: icon,
            contentPadding: const EdgeInsetsDirectional.all(15),
            hintStyle: TextStyle(
              color: const Color(0x600B1A51),
              fontSize: 14.sp,
              fontFamily: 'Somar Sans',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            prefixIconColor: const Color(0xff4051ad29)),
      );
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    return newValue;
  }
}
