import 'package:emergency_notifier/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  UserModel? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      name: user.displayName!,
      email: user.email!,
      photoUrl: user.photoURL!,
      phoneNumber: '',
      role: 'user',
      address: '',
    );
  }

  Stream<UserModel?>? get user {
    return _firebaseAuth.authStateChanges().map(
      (auth.User? authUser) {
        return _userFromFirebase(authUser);
      },
    );
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final data =
        await auth.FirebaseAuth.instance.signInWithCredential(credential);
    return _userFromFirebase(data.user);
  }

  Future logout() async {
    await _firebaseAuth.signOut();
  }
}
