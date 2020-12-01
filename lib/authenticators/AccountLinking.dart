import 'package:firebase_auth/firebase_auth.dart';
import 'package:pay_app/models/User.dart';

class AccountLinking {
  static Future linkAccountWith(User user) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    AuthCredential credential = EmailAuthProvider.getCredential(email: user.email, password: user.password);

    FirebaseUser firebaseUser = await auth.currentUser();

    firebaseUser.linkWithCredential(credential);
  }
}
