import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failures/failures.dart';
import '../entity/login_input.dart';
import '../repository/auth_repositories.dart';

class RegistrationUseCase {
  final AuthRepositories _authRepositories;

  RegistrationUseCase(this._authRepositories);

  Future<Either<Failure, UserCredential>> execute(LoginInput input) async {
    return await _authRepositories.registerViaEmail(input);
  }
}
