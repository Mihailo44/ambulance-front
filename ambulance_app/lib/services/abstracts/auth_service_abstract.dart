<<<<<<< HEAD

abstract class AuthServiceAbstract {
  Future<bool> login(String username, String password);
=======
abstract class AuthServiceAbstract {
  Future<void> login(String username, String password);
>>>>>>> main
  Future<void> refreshTokens();
  void logout();
}