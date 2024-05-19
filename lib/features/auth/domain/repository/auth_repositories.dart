import 'package:auth_app_firebase/features/auth/domain/entity/login_input.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failures/failures.dart';

abstract class AuthRepositories {
  Future<Either<Failure, UserCredential>> login(LoginInput input);

  Future<Either<Failure, UserCredential>> register(LoginInput input);

  Future<void> logOut();
}
