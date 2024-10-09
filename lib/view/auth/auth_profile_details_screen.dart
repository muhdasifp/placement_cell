import 'package:flutter/material.dart';
import 'package:placement_hub/provider/user_provider.dart';
import 'package:placement_hub/view/components/custom_text_field.dart';
import 'package:provider/provider.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final TextEditingController stream;
  final TextEditingController address;
  final TextEditingController skill;

  const ProfileDetailsScreen({
    super.key,
    required this.stream,
    required this.address,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'ATEES Industrial Training Trissur',
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                CustomTextField(controller: stream, label: "stream"),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: skill,
                  label: "add your skills",
                  suffix: IconButton(
                    onPressed: () {
                      user.addSkills(skill.text);
                      skill.clear();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 2,
                  children: user.skillsList
                      .map(
                        (e) => Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: Colors.black45)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: address,
                  label: "address",
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
              ],
            ),
          )
        ],
      ),
    );
  }
}
