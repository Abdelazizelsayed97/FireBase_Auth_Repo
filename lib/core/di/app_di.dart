import 'package:auth_app_firebase/features/auth/data_layer/%20repositories/auth_repositories_impl.dart';
import 'package:auth_app_firebase/features/auth/domain/repository/auth_repositories.dart';
import 'package:auth_app_firebase/features/auth/domain/use_case/registration_via_email_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/domain/use_case/log_out_use_case.dart';
import '../../features/auth/domain/use_case/login_use_case.dart';
import '../../features/auth/domain/use_case/registration_via_phone_number_use_case.dart';
import '../../features/auth/ui/cubit/auth_cubit.dart';

final injector = GetIt.instance;

class AppDi {
  static Future<void> setup() async {
    injector.registerFactory<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );

    injector
        .registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImpl());
    injector.registerLazySingleton(() => LoginUseCase(injector()));
    injector.registerLazySingleton(() => RegistrationUseCase(injector()));
    injector.registerLazySingleton(() => LogoutUseCase(injector()));
    injector.registerLazySingleton(
        () => RegistrationViaPhoneNumberUseCase(injector()));
    injector.registerFactory(
        () => AuthCubit(injector(), injector(), injector(), injector()));
  }
}
