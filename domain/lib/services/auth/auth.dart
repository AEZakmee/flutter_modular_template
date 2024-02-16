abstract interface class Auth {
  bool get isAuthenticated;
  Future<String> accessToken();
  Stream<bool> observeAuthenticated();
  Future<void> signIn();
  Future<void> signOut();
}
