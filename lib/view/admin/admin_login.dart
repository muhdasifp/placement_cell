import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:placement_hub/view/admin/admin_home.dart';
import 'package:placement_hub/view/components/custom_button.dart';
import 'package:placement_hub/view/components/custom_text_field.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: double.infinity,
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ADMIN',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: userController,
                        label: 'user name',
                        prefix: const Icon(Icons.person_2_outlined),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: passwordController,
                        label: 'password',
                        prefix: const Icon(Icons.lock_outline),
                        isPassword: true,
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        child: 'Admin Login',
                        onTap: () {
                          if (userController.text == 'admin' &&
                              passwordController.text == 'admin') {
                            Get.off(() => const AdminHome());
                          } else {
                            sendToastMessage(
                                message: 'Invalid user name or password');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
