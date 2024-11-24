
abstract class AuthServiceAbstract {
  Future<bool> login(String username, String password);
  Future<void> refreshTokens();
  void logout();
}