import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_hub/data/images.dart';
import 'package:placement_hub/model/job_model.dart';
import 'package:placement_hub/provider/user_job_provider.dart';
import 'package:placement_hub/view/detail/details_screen.dart';
import 'package:provider/provider.dart';

class SearchJobScreen extends StatefulWidget {
  const SearchJobScreen({super.key});

  @override
  State<SearchJobScreen> createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends State<SearchJobScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<UserJobProvider>().getAllJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Jobs'),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              focusNode: searchFocus,
              onTapOutside: (event) {
                searchFocus.unfocus();
              },
              onChanged: (value) {
                context.read<UserJobProvider>().searchForJobs(value);
              },
              cursorColor: Colors.blue,
              controller: searchController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: _FilterPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.tune),
                  ),
                  hintText: 'Search jobs...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none)),
            ),
          ),
        ),
      ),
      body: Consumer<UserJobProvider>(
        builder: (_, snap, __) {
          List<JobModel> myJobList =
              searchController.text.isEmpty ? snap.allJobs : snap.searchJobs;

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            padding: const EdgeInsets.all(12),
            itemCount:
                snap.temp.isEmpty ? myJobList.length : snap.filterJobs.length,
            itemBuilder: (context, index) {
              final JobModel job =
                  snap.temp.isEmpty ? myJobList[index] : snap.filterJobs[index];

              return _SearchJobCard(job: job);
            },
          );
        },
      ),
    );
  }
}

class _SearchJobCard extends StatelessWidget {
  const _SearchJobCard({required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(appLogo, height: 40, width: 40),
            const SizedBox(width: 10),
            Expanded(child: Text('${job.title}'.toUpperCase())),
            CircleAvatar(
              radius: 15,
              child: Center(child: Text('${job.applicants}')),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            textIcon(icon: Icons.villa, text: '${job.recruiter!.company}'),
            textIcon(icon: Icons.location_on_outlined, text: '${job.location}'),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: List.generate(
            job.skillRequired!.length,
            (i) => Text("☉ ${job.skillRequired![i]} "),
          ),
        ),
        Row(
          children: [
            textIcon(icon: Icons.currency_rupee, text: '${job.salary}'),
            const Spacer(),
            MaterialButton(
              height: 25,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                Get.to(() => DetailsScreen(job: job));
              },
              child: const Text("Apply"),
            )
          ],
        )
      ],
    );
  }

  Widget textIcon({required IconData icon, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon), const SizedBox(width: 5), Text(text)],
    );
  }
}

class _FilterPage extends StatelessWidget {
  const _FilterPage();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserJobProvider>(
      builder: (_, snap, __) {
        return Column(
          children: [
            const Text('Filter BY'),
            CheckboxListTile(
              title: const Text("Developer"),
              value: snap.temp.contains('Developer') ? true : false,
              onChanged: (value) {
                if (value!) {
                  snap.addToFilter('Developer');
                } else {
                  snap.removeFromFilter('Developer');
                }
              },
            ),
            CheckboxListTile(
              title: const Text("Designer"),
              value: snap.temp.contains('Designer') ? true : false,
              onChanged: (value) {
                if (value!) {
                  snap.addToFilter('Designer');
                } else {
                  snap.removeFromFilter('Designer');
                }
              },
            ),
            CheckboxListTile(
              title: const Text("Accountant"),
              value: snap.temp.contains('Accountant') ? true : false,
              onChanged: (value) {
                if (value!) {
                  snap.addToFilter('Accountant');
                } else {
                  snap.removeFromFilter('Accountant');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
