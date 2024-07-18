import 'package:events_app/User_App/controllers/offers/offers_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Newly',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThemesStyles.primary),
            ),
            Expanded(
              child: GetX<OffersController>(
                init: OffersController(),
                builder: (controller) {
                  if (controller.offersLoading.value) {
                    return const MainLoadingWidget();
                  }
                  if (controller.offersItems.isEmpty) {
                    return Center(
                      child: Opacity(
                        opacity: 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage(
                                  'assets/images/searchNotFoundImage.png'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              child: Text(
                                'There are no offers to show',
                                style: TextStyle(
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: controller.offersItems.length,
                    itemBuilder: (context, index) {
                      return OfferCard(index: index);
                    },
                  );
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
  final int index;

  const OfferCard({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return GetX<OffersController>(
      builder: (controller) {
        final offer = controller.offersItems[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      offer.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                        '${offer.discountPercentage}%',
                        style: TextStyle(color: Color(0xFFFBEFF6)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Spacer(flex: 1),
                    Text(
                      '\$${offer.oldPrice}',
                      style: TextStyle(
                        color: ThemesStyles.primary,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(flex: 2),
                    Text(
                      '\$${offer.newPrice}',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
