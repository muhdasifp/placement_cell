import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/model/user_model.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:placement_hub/view/home/home_screen.dart';
import 'package:placement_hub/view/landing/landing_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// login student
  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        Get.offAll(() => const HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///register student
  Future<void> registerUser(
      String name, String email, String password, String phone) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      if (user != null) {
        saveUserProfile(UserModel(
          uid: user.uid,
          email: email,
          password: password,
          name: name,
          phone: phone,
        ));
      }
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  /// save student profile to database
  Future<void> saveUserProfile(UserModel user) async {
    try {
      await _db.collection('users').doc(user.uid).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  /// update student profile to database
  Future<void> updateProfile(
      String stream, String address, List<String> skill) async {
    final uid = _auth.currentUser!.uid;
    try {
      await _db.collection('users').doc(uid).update({
        "stream": stream,
        "address": address,
        "skills": skill,
      });
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///logout student
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LandingScreen());
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///update student profile
  Future<void> editStudentProfile(String uid, String key, String value) async {
    try {
      await _db.collection('users').doc(uid).update({key: value});
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }
}
