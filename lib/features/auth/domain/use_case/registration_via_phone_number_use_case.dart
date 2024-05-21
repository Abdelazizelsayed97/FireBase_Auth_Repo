import 'package:auth_app_firebase/core/failures/failures.dart';
import 'package:auth_app_firebase/features/auth/domain/repository/auth_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationViaPhoneNumberUseCase {
  final AuthRepositories _authRepositories;

  RegistrationViaPhoneNumberUseCase(this._authRepositories);

  Future<Either<Failure, void>> execute({
    required String number,
    required void Function(PhoneAuthCredential credential)
        verificationCompleted,
    required void Function(FirebaseAuthException exception) verificationFailed,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
  }) async {
    return await _authRepositories.registerViaPhone(
        number: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
