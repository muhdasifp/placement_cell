import 'package:flutter/material.dart';
import 'package:placement_hub/view/components/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  const RegisterScreen({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: nameController,
                  label: 'name',
                  prefix: const Icon(Icons.person_outline),
                ),
                const SizedBox(height: 12),
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
                const SizedBox(height: 12),
                CustomTextField(
                  controller: phoneController,
                  label: 'number',
                  prefix: const Icon(Icons.call_outlined),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Get Back to login',
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
