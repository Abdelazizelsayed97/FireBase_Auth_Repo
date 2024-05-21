import 'package:auth_app_firebase/core/helper/spacing.dart';
import 'package:flutter/material.dart';

import '../../sign_up/widgets/phone_text_field.dart';

class RegisterViaPhoneNumber extends StatelessWidget {
  RegisterViaPhoneNumber({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('lib/assets/images/pngwing.com.png'),
            verticalSpace(50),
            PhoneTextField(controller: _controller),
            verticalSpace(30),
          ],
        ),
      ),
    );
  }
}
