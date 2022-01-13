import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  //SIGN UP METHOD
  Future signUp({
    String email,
    String password,
    String name,
  }) async {
    try {
      user = auth.currentUser;
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.updateDisplayName(name);
      await user.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({String email, String password}) async {
    try {
      user = auth.currentUser;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await auth.signOut();

    print('signout');
  }
}
