import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  AuthenticationRepository({required FirebaseAuth authService})
      : _authService = authService;

  final FirebaseAuth _authService;

  Future<User?> signInWithUserAndPassword(String email, String password) async {
    try {
      final userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (err) {
      rethrow;
    }
  }
}
