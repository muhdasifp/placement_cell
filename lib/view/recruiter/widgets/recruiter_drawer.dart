import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/provider/recruiter_provider.dart';
import 'package:placement_hub/view/recruiter/widgets/post_job_screen.dart';
import 'package:placement_hub/view/recruiter/widgets/recruiter_all_jobs.dart';
import 'package:provider/provider.dart';

class RecruiterDrawer extends StatelessWidget {
  const RecruiterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final recruiter = Provider.of<RecruiterProvider>(context).recruiter;
    return Drawer(
      backgroundColor: Colors.red,
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  child: Text(recruiter.company![0].toUpperCase()),
                ),
                const SizedBox(height: 20),
                Text(
                  recruiter.company ?? "",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  recruiter.email ?? "email address",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const PostJobScreen());
            },
            title: const Text("Post New Job"),
            trailing: const Icon(Icons.work_outline),
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          ListTile(
            onTap: () {
              Get.to(() => const RecruiterAllJobs());
            },
            title: const Text("All jobs"),
            trailing: const Icon(Icons.bookmark_border),
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          const Spacer(),
          ListTile(
            onTap: () {
              context.read<RecruiterProvider>().logoutRecruiter();
            },
            title: const Text("Logout"),
            trailing: const Icon(Icons.logout_outlined),
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
