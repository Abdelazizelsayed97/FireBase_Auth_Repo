import '../repository/auth_repositories.dart';

class LogoutUseCase {
  final AuthRepositories _authRepositories;

  LogoutUseCase(this._authRepositories);

  Future<void> execute() async {
    return await _authRepositories.logOut();
  }
}
