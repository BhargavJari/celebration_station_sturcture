import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  bool status;
  String? message;
  User? user;

  AuthResult({required this.status, this.message, this.user});

  @override
  String toString() {
    return '''AuthResult(
      status: $status,
      message: $message,
      user: $user
    )''';
  }
}
