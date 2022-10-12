
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticateRepo {
  static Future<String> signup(
      String email, String name, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      log(credential.toString());
      return 'Add Succeed';
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return 'Error';
    } catch (e) {
      log(e.toString());
      return 'Error';
    }
  }

  static Future<String> login(
      String email, String password) async {
    try {
      log(email);
      log(password);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log(credential.toString());
      return 'Login Succeed';
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
      return 'Error';
    } catch (e) {
      log(e.toString());
      return 'Error';
    }
  }

}
