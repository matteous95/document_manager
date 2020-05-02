import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String authUid;
  final String email;

  User({this.authUid, this.email});

  static Future<User> fromEntity(Future<FirebaseUser> firebaseUser) async {
    return User(
      authUid: (await firebaseUser).uid,
      email: (await firebaseUser).email,
    );
  }
}
