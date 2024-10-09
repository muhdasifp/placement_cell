import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_hub/data/images.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:placement_hub/view/components/chip.dart';
import 'package:placement_hub/view/components/custom_shimmer.dart';
import 'package:placement_hub/view/detail/details_screen.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('jobs').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<JobModel> jobs = getRandomList(
              snapshot.data!.docs.map((e) => JobModel.fromJson(e)).toList(), 6);
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return InkWell(
                onTap: () => Get.to(() => DetailsScreen(job: job)),
                child: Card(
                  elevation: 3,
                  color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(appLogo),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AutoSizeText('${job.title}'.toUpperCase(),
                                    maxLines: 1),
                                AutoSizeText('${job.recruiter!.company}',
                                    maxLines: 1),
                              ],
                            ),
                          ],
                        ),
                        buildRow(
                            title: '${job.location}',
                            icon: Icons.location_on_outlined),
                        buildRow(
                            title: '${job.salary}', icon: Icons.paid_outlined),
                        const SizedBox(height: 5),
                        SimpleChip(data: '${job.jobType}'),
                        const Divider(),
                        Text('${job.postDate}')
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomShimmer(
                height: MediaQuery.of(context).size.height * 0.23,
                width: 100,
              ),
            );
          },
        );
      },
    );
  }

  Row buildRow({required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 5),
        AutoSizeText(title, maxLines: 1),
      ],
    );
  }
}
