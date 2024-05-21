import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneTextField extends StatelessWidget {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller;
  final void Function(PhoneNumber)? onChanged;

  PhoneTextField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        // focusNode: focusNode,
        decoration: const InputDecoration(
          counter: SizedBox.shrink(),
          labelText: 'Phone Number',
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        languageCode: "en",
        onChanged: onChanged,
        onCountryChanged: (country) {
          controller.clear();
        },
        countries: const [
          Country(
              name: 'Egypt',
              flag: '🇪🇬',
              code: 'EG',
              dialCode: '20',
              nameTranslations: {
                'EG': 'Egypt',
              },
              minLength: 10,
              maxLength: 10)
        ],
        invalidNumberMessage:
            'Number format not Compatible with country phone number regex');
  }
}
