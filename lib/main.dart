import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_hub/data/theme.dart';
import 'package:placement_hub/firebase_options.dart';
import 'package:placement_hub/provider/admin_provider.dart';
import 'package:placement_hub/provider/my_provider.dart';
import 'package:placement_hub/provider/recruiter_provider.dart';
import 'package:placement_hub/provider/user_job_provider.dart';
import 'package:placement_hub/provider/user_provider.dart';
import 'package:placement_hub/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // initialize all providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RecruiterProvider()),
        ChangeNotifierProvider(create: (_) => UserJobProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Placement Hub',
        theme: myTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
