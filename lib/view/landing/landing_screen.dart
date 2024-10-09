import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/data/colors.dart';
import 'package:placement_hub/view/admin/admin_login.dart';
import 'package:placement_hub/view/auth/login_screen.dart';
import 'package:placement_hub/view/recruiter/recruiter_login.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.greenColor, AppColors.blueColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///student login
              InkWell(
                onTap: () {
                  Get.to(() => const LoginScreen());
                },
                child: buildContainer(color: Colors.amber, icon: Icons.school),
              ),
              const SizedBox(height: 15),
              const Text(
                'Student',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),

              ///recruiter login
              InkWell(
                onTap: () {
                  Get.to(() => const RecruiterLogin());
                },
                child: buildContainer(
                    icon: Icons.auto_stories, color: Colors.blue),
              ),
              const SizedBox(height: 15),
              const Text(
                'Recruiter',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),

              ///admin login
              InkWell(
                onTap: () {
                  Get.to(() => const AdminLogin());
                },
                child: buildContainer(
                    icon: Icons.admin_panel_settings_outlined,
                    color: Colors.green),
              ),
              const SizedBox(height: 15),
              const Text(
                'Admin',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer({required IconData icon, required Color color}) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.white24, offset: Offset(5, 5), blurRadius: 10)
          ]),
      child: Icon(icon, color: Colors.white, size: 70),
    );
  }
}
