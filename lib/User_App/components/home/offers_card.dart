import 'package:events_app/User_App/view/p-event/offer.dart';
import 'package:events_app/common/components/general/gradiant_Icon.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersCard extends StatelessWidget {
  const OffersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/images/OffersCardBackgroundGraident.jpeg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  //===================the Left Icon and its text===============
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(ThemesStyles.paddingprimary),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                100), // Half of container width/height for perfect circle
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset(
                                "assets/images/Logo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Offers Card',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //===================eND the Left Icon and its text===============
                  //===================Start the TAG ===============
                  Positioned(
                    top: ThemesStyles.paddingprimary + 20,
                    right: 20,
                    child: const GradientIcon(
                      icon: Icons.discount_outlined,
                      size: 40,
                      gradient: LinearGradient(
                        colors: [
                          ThemesStyles.primary,
                          Colors.black
                        ], // Replace with your gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  //===================End the TAG ===============
                  //===================Start the see offers ===============
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
//here we go to the offers page
                      },
                      child: Text(
                        'What are you wating for! Browse now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ThemesStyles.littelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Opacity(
                      opacity: 1
                      // - _animation!.value,
                      ,
                      child: MaterialButton(
                        onPressed: () {
                            Get.to(()=> OfferPage());

                        },
                        color: ThemesStyles.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'See Offers',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
