import 'package:auth_app_firebase/core/app_text_field/app_text_field.dart';
import 'package:auth_app_firebase/core/helper/spacing.dart';
import 'package:auth_app_firebase/features/auth/domain/entity/login_input.dart';
import 'package:auth_app_firebase/features/auth/login/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _confirmPassWordController = TextEditingController();
  final valueState = WidgetStatesController();
  final ValueNotifier<bool> _isValueNotifier = ValueNotifier(false);

  bool _isFilled() {
    if ((_emailController.text.isNotEmpty &&
        _passWordController.text.isNotEmpty &&
        _confirmPassWordController.text.isNotEmpty)) {
      _isValueNotifier.value = true;
    } else {
      _isValueNotifier.value = false;
    }
    return _isValueNotifier.value;
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
                verticalSpace(20),
                verticalSpace(20),
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
                AppTextField(
                  onChanged: (p0) {
                    _isFilled();
                    setState(() {});
                  },
                  controller: _confirmPassWordController,
                  label: 'Confirm Password',
                  validator: (p0) {
                    if (_confirmPassWordController.text !=
                        _passWordController.text) {
                      return 'Passwords do not match';
                    }
                    setState(() {});
                  },
                ),
                verticalSpace(20),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            _isFilled() ? Colors.transparent : Colors.grey),
                        fixedSize: WidgetStatePropertyAll<Size>(
                          Size.fromWidth(250.w),
                        ),
                      ),
                      onPressed: () {
                        _onPressed();
                      },
                      statesController: WidgetStatesController(),
                      child: (state is RegisterLoading)
                          ? const CircularProgressIndicator()
                          : const Text("Register"),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    if (_isFilled()) {
      print('hsgdjkf');
      context.read<AuthCubit>().register(LoginInput(
          email: _emailController.text, password: _passWordController.text));
    }
  }
}
