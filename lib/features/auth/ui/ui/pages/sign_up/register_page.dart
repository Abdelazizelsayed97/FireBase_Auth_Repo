import 'package:auth_app_firebase/core/app_text_field/app_text_field.dart';
import 'package:auth_app_firebase/core/helper/spacing.dart';
import 'package:auth_app_firebase/features/auth/domain/entity/login_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/button_widget/button_wiget.dart';
import '../../../cubit/auth_cubit.dart';
import '../home_page.dart';
import 'widgets/phone_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final valueState = WidgetStatesController();
  final ValueNotifier<bool> _isValueNotifier = ValueNotifier(false);

  bool _isFilled() {
    if ((_emailController.text.isNotEmpty &&
        _passWordController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty)) {
      _isValueNotifier.value = true;
    } else {
      _isValueNotifier.value = false;
    }
    return _isValueNotifier.value;
  }

  @override
  void initState() {
    _isFilled();
    super.initState();
  }

  void _handelPress(String phoneNumber) async {
    context.read<AuthCubit>().registerViaPhone('+20$phoneNumber');
    print('+20$phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
          print('Success');
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    filterQuality: FilterQuality.high,
                    alignment: Alignment.bottomCenter,
                    scale: 3,
                    'lib/assets/images/pngwing.com.png'),
                verticalSpace(30),
                AppTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  onChanged: (p0) {
                    _isFilled();
                    setState(() {});
                  },
                ),
                verticalSpace(20),
                AppTextField(
                  onChanged: (p0) {
                    _isFilled();
                    setState(() {});
                  },
                  controller: _passWordController,
                  label: 'Password',
                ),
                verticalSpace(20),
                PhoneTextField(
                  onChanged: (phone) {
                    print(phone.completeNumber);
                    _isFilled();
                    setState(() {});
                  },
                  controller: _phoneNumberController,
                ),
                verticalSpace(20),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AppButton(
                      onPress: () {
                        _onPressed();
                      },
                      color: _isFilled() ? Colors.transparent : Colors.grey,
                      child: (state is RegisterLoading)
                          ? const CircularProgressIndicator()
                          : const Text("Register"),
                    );
                  },
                ),
                MaterialButton(
                    color: Colors.red,
                    onPressed: () {
                      _handelPress(_phoneNumberController.text);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => VerifyPhoneNumberPage(
                      //               createAccount: () {
                      //                 print('======');
                      //     return _handelPress(_phoneNumberController.text);
                      //      },
                      //  )));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    if (_isFilled()) {
      context.read<AuthCubit>().registerViaEmail(LoginInput(
          email: _emailController.text, password: _passWordController.text));
    }
  }
}
