// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/utils/helpers.dart';
import '../../../controllers/auth_controller.dart';
import '../../../services/database_service.dart';
import '../views/screens/parent_screen.dart';

class EmailAuthService {
  AuthController authController = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  login(mail, password) async {
    authController.isLoading.value = true;
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );

      QuerySnapshot user = await DatabaseService().getUserInfo(mail);

      if (credential.user != null && user != null && user.docs[0] != null) {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['uid'] = user.docs[0].id;
        data['name'] = user.docs[0]['name'];
        data['image'] = user.docs[0]['image'];
        data['email'] = user.docs[0]['email'];
        data['phone'] = user.docs[0]['phone'];
        data['password'] = '';
        data['prodiver'] = 'email';

        // authController.saveUser(data);

        Get.offAll(
          () => const ParentScreen(2),
        );
      } else {
        showToast('Unknown error.');
      }
    } on FirebaseAuthException catch (e) {
      showToast(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      authController.isLoading.value = false;
    }
  }

  register(name, mail, password) async {
    authController.isLoading.value = true;
    //var uuid = await authController.getId();
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: mail, password: password);

      final User? user = credential.user;

      if (user != null) {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['uid'] = user.uid;
        data['name'] = name;
        data['image'] = user.photoURL;
        data['email'] = user.email;
        data['phone'] = user.phoneNumber;
        data['password'] = '';
        data['prodiver'] = 'email';
        //data['uuid'] = uuid;

        //authController.saveUser(data);
        Get.offAll(
          () => const ParentScreen(2),
        );
      }
    } on FirebaseAuthException catch (e) {
      showToast(e.message.toString());
    } catch (e) {
      //print(e);
    } finally {
      authController.isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
