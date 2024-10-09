import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/data/images.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/provider/my_provider.dart';
import 'package:placement_hub/provider/user_job_provider.dart';
import 'package:placement_hub/service/url_launcher_service.dart';
import 'package:placement_hub/view/components/custom_button.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  final JobModel job;

  const DetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back)),
              title: Text("${job.title}".toUpperCase()),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue.shade200,
                    child: Text("${job.applicants}"),
                  ),
                )
              ],
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              backgroundImage: AssetImage(appLogo),
                            ),
                            Text(
                              "${job.recruiter!.company}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Job Description",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text("${job.description}"),
                    const SizedBox(height: 10),
                    const Text(
                      "Salary",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.currency_rupee),
                        Text(
                          "${job.salary}",
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Job-Type",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text("${job.jobType}",
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    const Text(
                      "Skill Required",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: List.generate(
                        job.skillRequired!.length,
                        (index) => Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: Colors.black45)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Text(job.skillRequired![index],
                                style: const TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              UrlLauncherService()
                                  .launchPhoneCall("${job.recruiter!.number}");
                            },
                            label: const Text("Call Now"),
                            icon: const Icon(Icons.call),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              UrlLauncherService().launchEmail(
                                  "${job.recruiter!.email}", job.title!);
                            },
                            label: const Text("Send Mail"),
                            icon: const Icon(Icons.mail_outline),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: CustomButton(
                        child: "Apply",
                        onTap: () {
                          context.read<MyProvider>().toggle();
                          context
                              .read<UserJobProvider>()
                              .applyNewJobs(job)
                              .then((value) =>
                                  context.read<MyProvider>().toggle())
                              .onError((error, stackTrace) =>
                                  context.read<MyProvider>().toggle());
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Job Posted On ${job.postDate}",
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
