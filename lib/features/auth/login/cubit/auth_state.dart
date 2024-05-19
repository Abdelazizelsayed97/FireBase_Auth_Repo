part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  // Login states
  const factory AuthState.loginInitial() = _LoginInitial;

  const factory AuthState.loginLoading() = LoginLoading;

  const factory AuthState.loginSuccess({final UserCredential? credential}) =
      LoginSuccess;

  const factory AuthState.loginFailure(String message) = LoginFailure;

  // Register states
  const factory AuthState.registerInitial() = _RegisterInitial;

  const factory AuthState.registerLoading() = RegisterLoading;

  const factory AuthState.registerSuccess() = RegisterSuccess;

  const factory AuthState.registerFailure(String message) = RegisterFailure;

  // Logout states
  const factory AuthState.logoutLoading() = LogoutLoading;

  const factory AuthState.logoutSuccess() = LogoutSuccess;

  const factory AuthState.logoutFailure(String message) = LogoutFailure;
}
