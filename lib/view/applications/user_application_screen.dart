import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placement_hub/model/application_model.dart';
import 'package:placement_hub/provider/user_job_provider.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:provider/provider.dart';

class UserApplicationScreen extends StatelessWidget {
  const UserApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserJobProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Applications"),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('applications')
            .where('seeker.uid', isEqualTo: user.currentUser.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("No Data Found"));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Zero Applications"));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                ApplicationModel data =
                    ApplicationModel.fromJson(snapshot.data!.docs[index]);
                return Card(
                  color: getRandomFluorescentColor(),
                  child: ExpansionTile(
                    title: Text("${data.job!.title}".toUpperCase()),
                    subtitle: Text("${data.job!.location}"),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      Text('${data.job!.recruiter!.company}'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      data.status != 'interview'
                          ? Text('${data.status}')
                          : Text(
                              textAlign: TextAlign.center,
                              "You have an interview for the post ${data.job!.title} at the ${data.interviewPlace} on ${data.date}, ${data.interviewTime}",
                            )
                    ],
                  ),
                );
              },
            );
          }

          return const Center(child: Text("Something Went Wrong"));
        },
      ),
    );
  }
}
