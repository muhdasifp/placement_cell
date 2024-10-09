import 'package:flutter/material.dart';
import 'package:placement_hub/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AuthPrivacyScreen extends StatelessWidget {
  const AuthPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Terms and Conditions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20),
          const Text(
              r''' Welcome to [Your App Name] ("we", "our", "us"). We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and share information about you when you use our mobile application ("App").''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              )),
          const SizedBox(height: 35),
          Row(
            children: [
              Checkbox(
                value: auth.isAccept,
                onChanged: (value) {
                  auth.acceptContinue(value!);
                },
              ),
              const SizedBox(width: 10),
              const Text('Accept and Continue'),
            ],
          ),
        ],
      ),
    );
  }
}
