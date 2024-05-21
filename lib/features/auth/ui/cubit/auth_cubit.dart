import 'package:auth_app_firebase/core/failures/failures.dart';
import 'package:auth_app_firebase/features/auth/domain/entity/login_input.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/use_case/log_out_use_case.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/registration_via_email_use_case.dart';
import '../../domain/use_case/registration_via_phone_number_use_case.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._registrationUseCase,
    this._registrationViaPhoneNumberUseCase,
  ) : super(const AuthState.initial());
  late String verificationId;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegistrationUseCase _registrationUseCase;
  final RegistrationViaPhoneNumberUseCase _registrationViaPhoneNumberUseCase;

  Future<Either<Failure, UserCredential>> login({
    required LoginInput input,
  }) async {
    emit(const AuthState.loginLoading());
    final result = await _loginUseCase.execute(input);
    if (result is Right) {
      emit(const AuthState.loginSuccess());
    } else {
      emit(AuthState.loginFailure(result.foldLeft.toString()));
    }

    return result;
  }

  Future<void> signOut() async {
    emit(const AuthState.logoutLoading());
    try {
      final result = _logoutUseCase.execute().asStream();
      emit(const AuthState.logoutSuccess());
    } catch (e) {
      emit(AuthState.logoutFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserCredential>> registerViaEmail(
      LoginInput input) async {
    emit(const AuthState.registerLoading());
    final result = await _registrationUseCase.execute(input);
    if (result is Right) {
      emit(const AuthState.registerSuccess());
    } else {
      emit(AuthState.registerFailure(result.foldLeft.toString()));
    }

    return result;
  }

  Future<void> registerViaPhone(String number) async {
    final result = await _registrationViaPhoneNumberUseCase.execute(
      number: number,
      verificationCompleted: (credential) async {
        await signIn(credential);
      },
      verificationFailed: (exception) {
        print('verificationFailed : ${exception.toString()}');
        emit(ErrorOccurred(exception.toString()));
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId = verificationId;
        emit(const AuthState.phoneNumberSubmitted());
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (kDebugMode) {
          print('codeAutoRetrievalTimeout');
        }
      },
    );
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(const PhoneOTPVerified());
    } catch (error) {
      emit(ErrorOccurred(error.toString()));
    }
  }
}
