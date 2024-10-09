import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:placement_hub/provider/user_job_provider.dart';
import 'package:placement_hub/view/applications/user_application_screen.dart';
import 'package:placement_hub/view/home/search_job_screen.dart';
import 'package:placement_hub/view/home/widgets/drawer.dart';
import 'package:placement_hub/view/home/widgets/home_recently_added_grid.dart';
import 'package:placement_hub/view/home/widgets/home_slider.dart';
import 'package:placement_hub/view/home/widgets/job_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserJobProvider>().getCurrentUserProfile();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Badge(
              alignment: Alignment.centerRight,
              label: Consumer<UserJobProvider>(
                  builder: (_, value, __) =>
                      Text("${value.applicationNumber}")),
              child: IconButton(
                onPressed: () {
                  Get.to(() => const UserApplicationScreen());
                },
                icon: const Icon(Icons.notifications_on_outlined),
              ),
            ),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeSlider(),
            const SizedBox(height: 10),
            const Text(
              'Recently Added Jobs',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            const HomeRecentlyAddedGrid(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Most Searched Jobs',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const SearchJobScreen());
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Expanded(child: JobCard()),
          ],
        ),
      ),
    );
  }
}
