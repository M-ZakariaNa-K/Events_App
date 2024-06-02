import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Offer(),
    );
  }
}

class Offer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Newly',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ThemesStyles.primary),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 8,
                ),
                itemCount: 5, // Replace with the actual number of items
                itemBuilder: (context, index) {
                  return OfferCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                'assets/images/second_boanding.png', // Replace with your image asset
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Event Title',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ThemesStyles.primary,
                  shape: BoxShape.circle,
                ),
                height: 35,
                width: 35,
                child: Center(
                  child: Text(
                    "20%",
                    style: TextStyle(color: Color(0xFFFBEFF6)),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Spacer(flex: 1),
                Text(
                  '2000',
                  style: TextStyle(
                    color: ThemesStyles.primary,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 20,
                  ),
                ),
                Spacer(flex: 2),
                Text(
                  '1500',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.location_on, color: ThemesStyles.primary),
                SizedBox(width: 4),
                Text('Location', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
