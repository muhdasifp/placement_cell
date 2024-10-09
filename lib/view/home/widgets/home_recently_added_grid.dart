import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_hub/data/images.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/utility/helper.dart';
import 'package:placement_hub/view/components/custom_shimmer.dart';
import 'package:placement_hub/view/detail/details_screen.dart';

class HomeRecentlyAddedGrid extends StatelessWidget {
  const HomeRecentlyAddedGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('jobs').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<JobModel> recentJobs = getRecentJobs(
                snapshot.data!.docs.map((e) => JobModel.fromJson(e)).toList());
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentJobs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                var job = recentJobs[index];
                return Card(
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.asset(appLogo, height: 40, width: 40),
                            const SizedBox(width: 10),
                            Expanded(child: Text('${job.title}'.toUpperCase()))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.villa, size: 12),
                            Text(
                              '${job.recruiter!.company}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 12),
                            Text(
                              '${job.location}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_rupee,
                              size: 12,
                            ),
                            Text(
                              '${job.salary}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: MaterialButton(
                                height: 25,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                color: Colors.green,
                                textColor: Colors.white,
                                onPressed: () {
                                  Get.to(() => DetailsScreen(job: job));
                                },
                                child: const Text("Apply"),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return const CustomShimmer(height: 100, width: 110);
            },
          );
        },
      ),
    );
  }
}
