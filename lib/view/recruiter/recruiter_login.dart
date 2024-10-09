import 'package:flutter/material.dart';
import 'package:placement_hub/view/recruiter/widgets/recuiter_login_tab.dart';
import 'package:placement_hub/view/recruiter/widgets/recuiter_register_tab.dart';

class RecruiterLogin extends StatelessWidget {
  const RecruiterLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 80,
                    child: const TabBar(
                      tabs: [
                        Text("Login"),
                        Text("Register"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const TabBarView(
                      children: [
                        RecruiterLoginTab(),
                        RecruiterRegisterTab(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
