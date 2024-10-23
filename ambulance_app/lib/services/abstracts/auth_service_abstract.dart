abstract class AuthServiceAbstract {
  Future<void> login(String username, String password);
  Future<void> refreshTokens();
  void logout();
}