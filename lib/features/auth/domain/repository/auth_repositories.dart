import 'package:auth_app_firebase/features/auth/domain/entity/login_input.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failures/failures.dart';

abstract class AuthRepositories {
  Future<Either<Failure, UserCredential>> login(LoginInput input);

  Future<Either<Failure, UserCredential>> registerViaEmail(LoginInput input);

  Future<Either<Failure, void>> registerViaPhone({
    required String number,
    required void Function(PhoneAuthCredential credential)
        verificationCompleted,
    required void Function(FirebaseAuthException exception) verificationFailed,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
  });

  Future<void> logOut();
}
