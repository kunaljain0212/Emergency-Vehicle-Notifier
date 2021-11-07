import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:emergency_notifier/models/auth_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  AuthModel? _userFromFirebaseUser(User? user) {
    return user != null ? AuthModel(user.uid) : null;
  }

  // auth change user stream
  Stream<AuthModel?> get user {
    return _auth.idTokenChanges().map(_userFromFirebaseUser);
  }

  //sign up with email and password
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  //sign in with google
  Future signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // signout user
  Future signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
