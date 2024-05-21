import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/app_di.dart';
import 'features/auth/ui/cubit/auth_cubit.dart';
import 'features/auth/ui/ui/pages/home_page.dart';
import 'features/auth/ui/ui/pages/login/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      print('credential ${credential.verificationId}');
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {}
  }

  await AppDi.setup();
  runApp(const AppHome());
}

class AppHome extends StatelessWidget {
  const AppHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final credential = FirebaseAuth.instance.currentUser;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: BlocProvider<AuthCubit>(
        create: (context) =>
            AuthCubit(injector(), injector(), injector(), injector()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: credential == null ? const LoginPage() : const HomePage(),
        ),
      ),
    );
  }
}
