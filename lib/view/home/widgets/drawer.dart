import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/provider/user_job_provider.dart';
import 'package:placement_hub/service/auth_service.dart';
import 'package:placement_hub/view/applications/user_application_screen.dart';
import 'package:placement_hub/view/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserJobProvider>(context).currentUser;
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey.shade200,
                  child: Text(user.name![0].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                Text(user.name.toString()),
                Text(user.email.toString()),
              ],
            ),
          ),
          buildListTile(
            press: () {
              Get.to(() => const ProfileScreen());
            },
            icon: Icons.person,
            title: 'Profile',
          ),
          buildListTile(
            press: () {
              Get.to(() => const UserApplicationScreen());
            },
            icon: Icons.document_scanner,
            title: 'My Applications',
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: buildListTile(
              press: () {
                AuthService().logoutUser();
              },
              icon: Icons.logout,
              title: 'Logout',
            ),
          )
        ],
      ),
    );
  }

  ListTile buildListTile({
    required Function() press,
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      onTap: press,
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
