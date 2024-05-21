import 'package:auth_app_firebase/core/helper/spacing.dart';
import 'package:auth_app_firebase/features/auth/domain/entity/login_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/app_text_field/app_text_field.dart';
import '../../../../../../core/button_widget/button_wiget.dart';
import '../../../cubit/auth_cubit.dart';
import '../home_page.dart';
import '../sign_up/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                    filterQuality: FilterQuality.high,
                    alignment: Alignment.center,
                    scale: 3,
                    'lib/assets/images/pngwing.com.png'),
                verticalSpace(20),
                AppTextField(
                  label: 'email',
                  controller: emailController,
                ),
                verticalSpace(20),
                AppTextField(
                  label: 'password',
                  controller: passWordController,
                ),
                verticalSpace(40),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    Future.delayed(const Duration(seconds: 3));
                    return AppButton(
                      color: Colors.transparent,
                      child: (state is LoginLoading)
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                      onPress: () {
                        _login(
                            input: LoginInput(
                                email: emailController.text,
                                password: passWordController.text));
                      },
                    );
                  },
                ),
                verticalSpace(100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have An account ?"),
                    horizontalSpace(10),
                    InkWell(
                      child: const Text(
                        'Register',
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login({required LoginInput input}) async {
    try {
      await context.read<AuthCubit>().login(input: input);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
