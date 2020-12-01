import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_app/models/User.dart';


class EmailPassAuthentication {
  static Future<AuthResult> loginWithEmail(Function onErrorCallback,
      {@required String email, @required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    AuthResult authResult = await auth.signInWithEmailAndPassword(email: email, password: password).catchError(
      (error) {
        onErrorCallback.call();
        debugPrint(error.toString());
      },
    );
    return authResult;
  }

  static Future<AuthResult> signUpWithEmail({User user}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    user.provider = 'Email/Pass';

    AuthResult authResult = await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);

    try {
      await authResult.user.sendEmailVerification();
    } catch (e) {
      debugPrint('error while sending email verification !');
    }

    return authResult;
  }

  static Future linkWithEmalPass(User user) async {
    AuthCredential credential = EmailAuthProvider.getCredential(email: user.email, password: user.password);
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    firebaseUser.linkWithCredential(credential);
  }
}
