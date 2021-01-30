import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/models/Users.model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _setFirebaseUser(User user) {
    return user != null ? UserModel(user.uid, user.email) : null;
  }

  Future signInwithEmail(String email, String pwd) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pwd);

      User firebaseUser = result.user;

      return _setFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }

  Future signUpwithEmail(String email, String pwd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd);

      User firebaseUser = result.user;

      return _setFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }

  Future resetPwd(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential result = await _auth.signInWithCredential(credential);

      User firebaseUser = result.user;

      return _setFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
    }
  }
}
