import 'package:flutter/material.dart';
import 'package:placement_hub/provider/recruiter_provider.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:placement_hub/view/components/custom_button.dart';
import 'package:placement_hub/view/components/custom_text_field.dart';
import 'package:provider/provider.dart';

class RecruiterLoginTab extends StatefulWidget {
  const RecruiterLoginTab({super.key});

  @override
  State<RecruiterLoginTab> createState() => _RecruiterLoginTabState();
}

class _RecruiterLoginTabState extends State<RecruiterLoginTab> {
  final registerForm = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Form(
        key: registerForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Recruiter Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              validator: emailValidation,
              controller: emailController,
              label: 'email',
              prefix: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              validator: passwordValidator,
              controller: passwordController,
              label: 'password',
              prefix: const Icon(Icons.lock_outline),
              isPassword: true,
            ),

            const SizedBox(height: 24),

            ///login button
            CustomButton(
              child: 'Login',
              onTap: () {
                if (registerForm.currentState!.validate()) {
                  context.read<RecruiterProvider>().loginRecruiter(
                        emailController.text,
                        passwordController.text,
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
