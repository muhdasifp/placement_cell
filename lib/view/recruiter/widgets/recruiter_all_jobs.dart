import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placement_hub/provider/recruiter_provider.dart';
import 'package:provider/provider.dart';

class RecruiterAllJobs extends StatelessWidget {
  const RecruiterAllJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final recruiter = context.read<RecruiterProvider>().recruiter;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .where('recruiter.company', isEqualTo: recruiter.company)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("No Data Found!"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.red));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                return ListTile(
                  leading: IconButton(
                      onPressed: () {
                        context.read<RecruiterProvider>().deleteJob(data.id);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red)),
                  title: Text(data['title']),
                  subtitle: Text(data['post_date']),
                  trailing: Text(data['applicants'].toString()),
                );
              },
            );
          }
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
