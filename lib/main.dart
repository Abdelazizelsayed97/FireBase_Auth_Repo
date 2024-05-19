import 'package:auth_app_firebase/features/auth/login/cubit/auth_cubit.dart';
import 'package:auth_app_firebase/features/auth/login/ui/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/app_di.dart';
import 'features/auth/login/ui/pages/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        create: (context) => AuthCubit(injector(), injector(), injector()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: credential == null ? const LoginPage() : const HomePage(),
        ),
      ),
    );
  }
}
