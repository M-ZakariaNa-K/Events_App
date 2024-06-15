// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:events_app/common/core/constants/theme.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({
    Key? key,
    required this.isUserCameFromDrawer,
  }) : super(key: key);
  final bool isUserCameFromDrawer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isUserCameFromDrawer
          ? null
          : AppBar(
              title: Text(
                'Help Center',
                style: TextStyle(fontSize: ThemesStyles.mainFontSize),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
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
      'answer':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'How to make a payment?',
      'answer':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'How do I can cancel booking?',
      'answer':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'How do I can delete my account?',
      'answer':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'How do I exit the app?',
      'answer':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
            indicatorColor: ThemesStyles.primary,
            labelColor: ThemesStyles.primary,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              children: [
                buildFaqList(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Several services are available within the application, namely: booking halls in addition to booking the organizers service to help organize special events, and you can also attend public events that are available on our application only',
                    style: TextStyle(
                      fontSize: ThemesStyles.littelFontSize,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Our application has several payment services, namely: either electronic payment or cash payment, depending on the convenience of the user',
                    style: TextStyle(
                      fontSize: ThemesStyles.littelFontSize,
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
            style: TextStyle(fontSize: ThemesStyles.mainFontSize),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                TopBar[index]['answer']!,
                style: TextStyle(
                    fontSize: ThemesStyles.littelFontSize,
                    color: ThemesStyles.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}
