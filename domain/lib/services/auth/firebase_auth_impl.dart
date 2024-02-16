import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';

class FirebaseAuthImpl implements Auth {
  FirebaseAuthImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  @override
  Future<String> accessToken() async {
    final token = await _firebaseAuth.currentUser!.getIdToken();
    return token ?? '';
  }

  @override
  Stream<bool> observeAuthenticated() => _firebaseAuth.userChanges().map(
        (user) => user != null,
      );

  @override
  Future<void> signIn() => _firebaseAuth.signInAnonymously();

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}
