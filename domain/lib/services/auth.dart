import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Auth({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  Future<String> accessToken() async {
    final token = await _firebaseAuth.currentUser!.getIdToken();
    return token ?? '';
  }

  Stream<bool> observeAuthenticated() async* {
    yield _firebaseAuth.currentUser != null;
    yield* _firebaseAuth.userChanges().map(
          (user) => user != null,
        );
  }

  Future<bool> signIn() async {
    //This is only to mock login
    await _firebaseAuth.signInAnonymously();
    return true;
  }

  Future<void> signOut() => _firebaseAuth.signOut();
}
