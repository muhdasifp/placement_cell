import 'package:flutter/material.dart';
import 'package:placement_hub/provider/user_provider.dart';
import 'package:placement_hub/service/auth_service.dart';
import 'package:placement_hub/view/auth/auth_profile_details_screen.dart';
import 'package:placement_hub/view/auth/auth_privacy_screen.dart';
import 'package:placement_hub/view/auth/register_screen.dart';
import 'package:placement_hub/view/components/custom_button.dart';
import 'package:provider/provider.dart';

class StepperBar extends StatefulWidget {
  const StepperBar({super.key});

  @override
  State<StepperBar> createState() => _StepperBarState();
}

class _StepperBarState extends State<StepperBar> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  final TextEditingController streamController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    skillController.dispose();
    streamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, auth, child) {
            return Stepper(
              currentStep: auth.stepperIndex,
              steps: [
                ///for register email password number name
                Step(
                  isActive: auth.stepperIndex > 0,
                  state: auth.stepperIndex == 0
                      ? StepState.editing
                      : auth.stepperIndex > 0
                          ? StepState.complete
                          : StepState.indexed,
                  title: const Text("Register"),
                  content: RegisterScreen(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    phoneController: phoneController,
                  ),
                ),

                /// for updating stream skills & address,
                Step(
                  isActive: auth.stepperIndex > 1,
                  state: auth.stepperIndex == 1
                      ? StepState.editing
                      : auth.stepperIndex > 1
                          ? StepState.complete
                          : StepState.indexed,
                  title: const Text("Profile"),
                  content: ProfileDetailsScreen(
                    stream: streamController,
                    address: addressController,
                    skill: skillController,
                  ),
                ),

                ///for terms and condition's
                Step(
                  isActive: auth.stepperIndex > 2,
                  state: auth.stepperIndex == 2
                      ? StepState.editing
                      : auth.stepperIndex > 2
                          ? StepState.complete
                          : StepState.indexed,
                  title: const Text("Finish"),
                  content: const AuthPrivacyScreen(),
                ),
              ],
              type: StepperType.horizontal,
              controlsBuilder: (context, details) {
                switch (auth.stepperIndex) {
                  case 0:
                    return CustomButton(
                      child: 'Register',
                      onTap: () {
                        authService
                            .registerUser(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                phoneController.text)
                            .then((value) {
                          auth.updateIndex();
                        });
                      },
                    );
                  case 1:
                    return CustomButton(
                      child: 'Upload',
                      onTap: () {
                        authService
                            .updateProfile(streamController.text,
                                addressController.text, auth.skillsList)
                            .then((value) {
                          auth.skillsList.clear();
                          auth.updateIndex();
                        });
                      },
                    );
                  case 2:
                    return CustomButton(
                      child: 'Continue',
                      onTap: () {
                        auth.enterHome();
                      },
                    );
                  default:
                    return const SizedBox();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
