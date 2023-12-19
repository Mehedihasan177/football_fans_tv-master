import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/widgets.dart';
import '/utils/helpers.dart';

import '/controllers/auth_controller.dart';

class GoogleAuthService {
  AuthController authController = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  signIn() async {
    authController.isLoading.value = true;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);

      final User? user = authResult.user;
      // dd(user);
      if (user != null) {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['name'] = user.displayName;
        data['email'] = user.email;
        data['password'] = user.uid;
        data['password_confirmation'] = user.uid;
        data['provider'] = 'google';
        dd(data);
        authController.signUp(data);
      }

      return;
    } catch (e) {
      authController.isLoading.value = false;
      showToast("A problem occured. Try again in a minute");
      dd(e);
      //throw (e);
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
  }
}
