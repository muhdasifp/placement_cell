import 'package:flutter/material.dart';
import 'package:placement_hub/provider/recruiter_provider.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:placement_hub/view/components/custom_button.dart';
import 'package:placement_hub/view/components/custom_text_field.dart';
import 'package:provider/provider.dart';

class RecruiterRegisterTab extends StatefulWidget {
  const RecruiterRegisterTab({super.key});

  @override
  State<RecruiterRegisterTab> createState() => _RecruiterRegisterTabState();
}

class _RecruiterRegisterTabState extends State<RecruiterRegisterTab> {
  final loginForm = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    companyController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Form(
        key: loginForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Recruiter Register',
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
            const SizedBox(height: 12),
            CustomTextField(
              validator: textFieldValidator,
              controller: numberController,
              label: 'number',
              prefix: const Icon(Icons.call),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              validator: textFieldValidator,
              controller: companyController,
              label: 'company',
              prefix: const Icon(Icons.apartment_outlined),
            ),
            const SizedBox(height: 24),

            ///login button
            CustomButton(
              child: 'Register',
              onTap: () {
                if (loginForm.currentState!.validate()) {
                  context.read<RecruiterProvider>().registerRecruiter(
                        emailController.text,
                        passwordController.text,
                        companyController.text,
                        numberController.text,
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
