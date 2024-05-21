import 'package:auth_app_firebase/core/failures/failures.dart';
import 'package:auth_app_firebase/features/auth/domain/entity/login_input.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repository/auth_repositories.dart';
import '../model/login_network_input_model.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Failure(message: 'Failed to log out: $e');
    }
  }

  @override
  Future<Either<Failure, UserCredential>> login(LoginInput input) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: input.email,
        password: input.password,
      );
      return Right(result);
    } catch (e) {
      return Left(Failure(message: 'Failed to login: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> registerViaEmail(
      LoginInput input) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: NetworkLoginInputModel.fromInput(input).email,
        password: NetworkLoginInputModel.fromInput(input).password,
      );
      return Right(result);
    } catch (e) {
      return Left(Failure(message: left.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerViaPhone({
    required String number,
    required void Function(PhoneAuthCredential credential)
        verificationCompleted,
    required void Function(FirebaseAuthException exception) verificationFailed,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
      return const Right(null);
    } catch (error) {
      return Left(
        Failure(
          message: left.toString(),
        ),
      );
    }
  }
}
