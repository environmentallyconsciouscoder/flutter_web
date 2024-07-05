class AuthenticationService {
  bool _loginStatus = false;

  bool userLoggedIn() {
    return _loginStatus;
  }

  void updateLoginStatus() {
    _loginStatus = true;
  }

  void logout() {
    _loginStatus = false;
  }
}
