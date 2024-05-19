import 'package:auth_app_firebase/features/auth/domain/entity/login_input.dart';
import 'package:auth_app_firebase/features/auth/domain/repository/auth_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failures/failures.dart';

class LoginUseCase {
  final AuthRepositories _authRepositories;

  LoginUseCase(this._authRepositories);

  Future<Either<Failure, UserCredential>> execute(LoginInput input) async {
    return await _authRepositories.login(input);
  }
}
