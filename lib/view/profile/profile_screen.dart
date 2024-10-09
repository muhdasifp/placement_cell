import 'package:flutter/material.dart';
import 'package:placement_hub/data/images.dart';
import 'package:placement_hub/provider/user_job_provider.dart';
import 'package:placement_hub/service/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Consumer<UserJobProvider>(
                builder: (_, value, __) {
                  final user = value.currentUser;
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Stack(
                          children: [
                            Opacity(
                              opacity: 0.2,
                              child: Image.asset(appLogo),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                user.email![0].toUpperCase(),
                                style: const TextStyle(fontSize: 48),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          nameController.text = "${user.name}";
                          updateShowDialog(
                            context,
                            nameController,
                            'name',
                            "${user.uid}",
                          );
                        },
                        leading: const Icon(Icons.person_outline),
                        title: Text("${user.name}"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email_outlined),
                        title: Text("${user.email}"),
                      ),
                      ListTile(
                        onTap: () {
                          numberController.text = '${user.phone}';
                          updateShowDialog(
                            context,
                            numberController,
                            'phone',
                            "${user.uid}",
                          );
                        },
                        leading: const Icon(Icons.call),
                        title: Text("${user.phone}"),
                      ),
                      ListTile(
                        onTap: () {
                          addressController.text = '${user.address}';
                          updateShowDialog(
                            context,
                            addressController,
                            'address',
                            "${user.uid}",
                          );
                        },
                        leading: const Icon(Icons.home_outlined),
                        title: Text("${user.address}"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.work_history_outlined),
                        title: Wrap(
                          children: List.generate(
                            user.skills!.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Text("${user.skills![index]}, "),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> updateShowDialog(
    BuildContext context,
    TextEditingController controller,
    String field,
    String uid,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Profile"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _authService.editStudentProfile(uid, field, controller.text);
              Navigator.pop(context);
              context.read<UserJobProvider>().getCurrentUserProfile();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
