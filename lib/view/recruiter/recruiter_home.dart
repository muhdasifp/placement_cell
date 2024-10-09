import 'package:flutter/material.dart';
import 'package:placement_hub/provider/recruiter_provider.dart';
import 'package:placement_hub/view/recruiter/widgets/application_screen.dart';
import 'package:placement_hub/view/recruiter/widgets/recruiter_drawer.dart';
import 'package:provider/provider.dart';

class RecruiterHome extends StatelessWidget {
  const RecruiterHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RecruiterProvider>().getApplications();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Applications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      drawer: const RecruiterDrawer(),
      body: const RecruiterApplicationScreen(),
    );
  }
}
