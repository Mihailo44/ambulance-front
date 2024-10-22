abstract class AuthServiceAbstract {
  Future<void> login(String username, String password) async{}
  Future<void> refreshTokens() async{}
  void logout() async {}
}