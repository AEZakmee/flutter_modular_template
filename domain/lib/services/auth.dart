import 'dart:async';

class Auth {
  String? token;
  final _controller = StreamController<String?>.broadcast();

  bool get isAuthenticated => token != null;

  void _updateToken(String? newToken) {
    token = newToken;
    _controller.add(newToken);
  }

  Future<String> accessToken() async {
    return token ?? '';
  }

  Stream<bool> observeAuthenticated() =>
      _controller.stream.map((token) => token != null);

  Future<bool> signIn() async {
    _updateToken('token');
    return true;
  }

  Future<void> signOut() async => _updateToken(null);

  void dispose() {
    _controller.close();
  }
}
