import 'package:flutter/material.dart';
import 'package:placement_hub/provider/admin_provider.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminProvider>().getAllJobs();
    context.read<AdminProvider>().getAllRecruiter();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: TabBar(
              tabs: [
                Text("JOBS", style: TextStyle(fontSize: 26)),
                Text("RECRUITER", style: TextStyle(fontSize: 26)),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            AdminJobScreen(),
            AdminRecruiterScreen(),
          ],
        ),
      ),
    );
  }
}

class AdminJobScreen extends StatelessWidget {
  const AdminJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (_, value, __) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: value.allJobs.length,
          itemBuilder: (context, index) {
            final data = value.allJobs[index];
            return ListTile(
              title: Text('${data.recruiter!.company}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${data.title}"),
                  Text("${data.salary}"),
                  Text("${data.location}"),
                ],
              ),
              trailing: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<AdminProvider>().deleteJob(data.id!);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  Text("${data.applicants}"),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}

class AdminRecruiterScreen extends StatelessWidget {
  const AdminRecruiterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (_, value, __) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: value.allRecruiter.length,
          itemBuilder: (context, index) {
            final data = value.allRecruiter[index];
            return ListTile(
              title: Text('${data.company}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${data.email}"),
                  Text("${data.password}"),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  context.read<AdminProvider>().deleteRecruiter(data.id!);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}
