import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelpCenterPage(),
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: HelpCenter(),
    );
  }
}

class HelpCenter extends StatelessWidget {
  final List<Map<String, String>> TopBar = [
    {
      'question': 'What is Eveno?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'How to make a payment?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'How do I can cancel booking?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'How do I can delete my account?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'How do I exit the app?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'FAQ'),
              Tab(text: 'Service'),
              Tab(text: 'Payment'),
            ],
            labelColor: ThemesStyles.primary,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              children: [
                buildFaqList(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      'Several services are available within the application, namely: booking halls in addition to booking the organizers service to help organize special events, and you can also attend public events that are available on our application only',
                      style: TextStyle(fontSize: 18, color: ThemesStyles.primary),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      'Our application has several payment services, namely: either electronic payment or cash payment, depending on the convenience of the user',
                      style: TextStyle(fontSize: 18, color: ThemesStyles.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFaqList() {
    return ListView.builder(
      itemCount: TopBar.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(
            TopBar[index]['question']!,
            style: TextStyle(fontSize: 20),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                TopBar[index]['answer']!,
                style: TextStyle(fontSize: 18, color: ThemesStyles.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}
