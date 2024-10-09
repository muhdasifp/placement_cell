import 'package:flutter/material.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/provider/my_provider.dart';
import 'package:placement_hub/provider/recruiter_provider.dart';
import 'package:placement_hub/view/components/custom_button.dart';
import 'package:placement_hub/view/components/custom_text_field.dart';
import 'package:provider/provider.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController skill = TextEditingController();

  List<String> jobTypesList = ["remote", "hybrid", "part-time", "full-time"];

  List<String> jobCategory = ["Developer", "Designer", "Accountant"];

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    salary.dispose();
    location.dispose();
    skill.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecruiterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Job'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CustomTextField(controller: title, label: 'job title'),
                  const SizedBox(height: 10),
                  CustomTextField(
                    maxLines: 2,
                    controller: description,
                    label: 'description',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: salary,
                    label: 'salary range',
                    prefix: const Icon(Icons.currency_rupee_sharp),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      isExpanded: true,
                      hint: const Text("select job type"),
                      items: jobTypesList
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.toString())))
                          .toList(),
                      onChanged: (value) {
                        provider.getJobType(value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      isExpanded: true,
                      hint: const Text("select job category"),
                      items: jobCategory
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.toString())))
                          .toList(),
                      onChanged: (value) {
                        provider.getJobType(value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(controller: location, label: 'job location'),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: skill,
                    label: 'add skill',
                    suffix: IconButton(
                      onPressed: () {
                        provider.addSkills(skill.text);
                        skill.clear();
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      children: List.generate(
                        provider.skillsList.length,
                        (index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black54)),
                            child: Text(provider.skillsList[index]),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      child: 'Post Job',
                      onTap: () {
                        context.read<MyProvider>().toggle();
                        provider
                            .postJob(JobModel(
                                title: title.text,
                                description: description.text,
                                salary: salary.text,
                                location: location.text))
                            .then((value) {
                          context.read<MyProvider>().toggle();
                          title.clear();
                          description.clear();
                          salary.clear();
                          location.clear();
                          skill.clear();
                          provider.skillsList.clear();
                        }).onError((error, stackTrace) {
                          context.read<MyProvider>().toggle();
                        });
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
