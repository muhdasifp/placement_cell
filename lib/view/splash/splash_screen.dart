import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_hub/data/images.dart';
import 'package:placement_hub/service/connections_controller.dart';
import 'package:placement_hub/view/home/home_screen.dart';
import 'package:placement_hub/view/landing/landing_screen.dart';
import 'package:placement_hub/view/recruiter/recruiter_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkProfile();
    super.initState();
  }

  //for check if user is logged in then navigate based on role
  Future<void> checkProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        String role = userDoc.get('role');
        role == 'student'
            ? Get.offAll(() => const HomeScreen())
            : Get.offAll(() => const RecruiterHome());
      } else {
        Get.offAll(() => const LandingScreen());
      }
    });
    Get.put<ConnectivityController>(ConnectivityController());
  }

  @override
  Widget build(BuildContext context) {
    //ui of the splash screen
    return Scaffold(
      body: Center(
        child: Image.asset(appLogo),
      ),
    );
  }
}
