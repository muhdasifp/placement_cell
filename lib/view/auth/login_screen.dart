import 'package:flutter/material.dart';
import 'package:placement_hub/provider/my_provider.dart';
import 'package:placement_hub/provider/user_provider.dart';
import 'package:placement_hub/service/auth_service.dart';
import 'package:placement_hub/view/auth/stepper_bar.dart';
import 'package:placement_hub/view/components/custom_button.dart';
import 'package:placement_hub/view/components/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hey, welcome back!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: emailController,
                    label: 'email',
                    prefix: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: passwordController,
                    label: 'password',
                    prefix: const Icon(Icons.lock_outline),
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),

                  ///if new student navigate to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("New User?"),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StepperBar()),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),

                  ///login button
                  CustomButton(
                    child: 'Login',
                    onTap: () {
                      context.read<MyProvider>().toggle();
                      authService
                          .loginUser(
                              emailController.text, passwordController.text)
                          .then((value) {
                        context.read<MyProvider>().toggle();
                        // Provider.of<UserProvider>(context).updateIndex();
                      }).onError((error, stackTrace) {
                        context.read<MyProvider>().toggle();
                      });
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
