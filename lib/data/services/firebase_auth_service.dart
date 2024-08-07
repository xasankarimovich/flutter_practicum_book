import 'package:buksam_flutter_practicum/data/models/network_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth authService = FirebaseAuth.instance;

  Future<NetworkResponse> register(String email, String password) async {
    try {
      await authService.createUserWithEmailAndPassword(
          email: email, password: password);
      return NetworkResponse(
        data: authService.currentUser,
      );
    } catch (e) {
      return NetworkResponse(
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> login(String email, String password) async {
    try {
      await authService.signInWithEmailAndPassword(
          email: email, password: password);
      return NetworkResponse(
        data: authService.currentUser,
      );
    } catch (e) {
      return NetworkResponse(
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await authService.signOut();
  }
}
