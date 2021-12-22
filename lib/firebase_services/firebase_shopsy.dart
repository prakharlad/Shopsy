// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseShopsy {
  Future<FirebaseApp> shopsyInitialize() {
    return Firebase.initializeApp();
  }

  Future getProductRef() async {
    await FirebaseShopsy().productsCollection();
  }

  Future<CollectionReference<Map<String, dynamic>>> productsCollection() async {
    return FirebaseFirestore.instance.collection("Products");
  }

  Future CreateUser({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // User? _user = await FirebaseAuth.instance.currentUser;
      return null;
    } on FirebaseException catch (e) {
      if (e.code == "weak-password") {
        return "Password provided is too week";
      } else if (e.code == "email-already-in-use") {
        return "The account already in use for that email";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future LoginUser({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseException catch (e) {
      if (e.code == "ERROR_USER_NOT_FOUND") {
        return "User with this email doesn't exist.";
      } else if (e.code == "ERROR_INVALID_EMAIL") {
        return "Your email address appears to be malformed.";
      } else if (e.code == "ERROR_WRONG_PASSWORD") {
        return "Your password is wrong.";
      } else if (e.code == "ERROR_USER_DISABLED") {
        return "User with this email has been disabled.";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
