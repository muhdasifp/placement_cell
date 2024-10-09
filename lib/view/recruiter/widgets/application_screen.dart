import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placement_hub/provider/recruiter_provider.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:provider/provider.dart';

class RecruiterApplicationScreen extends StatelessWidget {
  const RecruiterApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recruiter = Provider.of<RecruiterProvider>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('applications')
            .where('job.recruiter.company',
                isEqualTo: recruiter.recruiter.company)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("No Data Found"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Zero Applications"));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text("${data['seeker']['name']}"),
                              Text("${data['seeker']['email']}"),
                              Text("${data['seeker']['phone']}"),
                            ],
                          ),
                          const Spacer(),
                          Text("${data['status']}"),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttons(
                              tap: () {
                                recruiter.respondApplication(
                                    'pending', data.id);
                              },
                              text: "Pending",
                              color: Colors.orange),
                          buttons(
                              tap: () {
                                recruiter.respondApplication(
                                    'rejected', data.id);
                              },
                              text: "Reject",
                              color: Colors.red),
                          buttons(
                              tap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _AdminScheduleInterviewBox(
                                          "${data['id']}"),
                                    ),
                                  ),
                                );
                              },
                              text: "Schedule Interview",
                              color: Colors.green)
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  MaterialButton buttons(
      {required VoidCallback tap, required String text, required Color color}) {
    return MaterialButton(
      height: 32,
      onPressed: tap,
      color: color,
      textColor: Colors.white,
      child: Text(text),
    );
  }
}

class _AdminScheduleInterviewBox extends StatefulWidget {
  final String applicationId;

  const _AdminScheduleInterviewBox(this.applicationId);

  @override
  State<_AdminScheduleInterviewBox> createState() =>
      _AdminScheduleInterviewBoxState();
}

class _AdminScheduleInterviewBoxState
    extends State<_AdminScheduleInterviewBox> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    dateController.dispose();
    placeController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                hintText: 'picked date',
                suffixIcon: IconButton(
                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 60),
                      ),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dateController.text = formatDate(pickedDate);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(hintText: 'interview location'),
              controller: placeController,
              validator: (value) =>
                  value!.isEmpty ? 'Please add interview location' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(hintText: 'interview time'),
              controller: timeController,
              validator: (value) =>
                  value!.isEmpty ? 'Please add interview time' : null,
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<RecruiterProvider>().scheduleInterView(
                        applicationId: widget.applicationId,
                        date: dateController.text,
                        place: placeController.text,
                        time: timeController.text,
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text('Schedule Interview'),
            )
          ],
        ),
      ),
    );
  }
}
