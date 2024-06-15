// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:events_app/User_App/view/p-event/p_event_details.dart';
import 'package:events_app/User_App/view/p-event/puplic_card.dart';
import 'package:events_app/common/core/constants/theme.dart';

class PublicEventPage extends StatefulWidget {
  PublicEventPage({
    Key? key,
    required this.isUserLoggedIn,
  }) : super(key: key);
  final bool isUserLoggedIn;
  @override
  State<PublicEventPage> createState() => _PublicEventPageState();
}

class _PublicEventPageState extends State<PublicEventPage> {
  bool isAll = true;

  bool isCultural = false;

  bool isEntertaining = false;

  bool isSocial = false;

  bool isEdiucational = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: token != ""
          ? null
          : AppBar(
              title: const Text("Public Events"),
              titleTextStyle: const TextStyle(
                color: Color(0xff464646),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              leading: IconButton(
                color: ThemesStyles.textColor,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
            ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ThemesStyles.paddingprimary,
            vertical: ThemesStyles.paddingprimary),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //فعاليات عامة
            const PuplicEventCard(
              isNewOnApp: false,
              image: 'assets/images/person.png',
              content: "organizers",
              width: 200,
            ),
            //=====================================3=======================================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAll = true;
                          isCultural = false;

                          isEntertaining = false;

                          isSocial = false;

                          isEdiucational = false;
                        });
                      },
                      child: Container(
                        width: 90,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            color: isAll
                                ? ThemesStyles.primary
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: isAll
                                ? null
                                : Border.all(
                                    color: ThemesStyles.primary, width: 1)),
                        child: Center(
                            child: Text(
                          "All",
                          style: TextStyle(
                            color: isAll
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCultural = true;
                          isAll = false;
                          isEntertaining = false;

                          isSocial = false;

                          isEdiucational = false;
                        });
                      },
                      child: Container(
                        width: 90,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            color: isCultural
                                ? ThemesStyles.primary
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: isCultural
                                ? null
                                : Border.all(
                                    color: ThemesStyles.primary, width: 1)),
                        child: Center(
                            child: Text(
                          "Cultural",
                          style: TextStyle(
                            color: isCultural
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEdiucational = true;
                          isAll = false;
                          isCultural = false;

                          isEntertaining = false;

                          isSocial = false;
                        });
                      },
                      child: Container(
                        width: 90,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            color: isEdiucational
                                ? ThemesStyles.primary
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: isEdiucational
                                ? null
                                : Border.all(
                                    color: ThemesStyles.primary, width: 1)),
                        child: Center(
                            child: Text(
                          "Ediucational",
                          style: TextStyle(
                            color: isEdiucational
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEntertaining = true;

                          isAll = false;

                          isCultural = false;

                          isSocial = false;

                          isEdiucational = false;
                        });
                      },
                      child: Container(
                        width: 90,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            color: isEntertaining
                                ? ThemesStyles.primary
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: isEntertaining
                                ? null
                                : Border.all(
                                    color: ThemesStyles.primary, width: 1)),
                        child: Center(
                            child: Text(
                          "Entertaining",
                          style: TextStyle(
                            color: isEntertaining
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSocial = true;

                          isAll = false;

                          isCultural = false;

                          isEntertaining = false;

                          isEdiucational = false;
                        });
                      },
                      child: Container(
                        width: 90,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            color: isSocial
                                ? ThemesStyles.primary
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: isSocial
                                ? null
                                : Border.all(
                                    color: ThemesStyles.primary, width: 1)),
                        child: Center(
                            child: Text(
                          "Social",
                          style: TextStyle(
                            color: isSocial
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //=====================================4======================================
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(P_Event_Details());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xff2B2B2B)
                            : const Color.fromARGB(255, 243, 243, 243),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/images/Logo.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: ThemesStyles.primary,
                                width: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "International Concert",
                                    style: TextStyle(
                                      fontSize: ThemesStyles.mainFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    width: 200,
                                    child: Text(
                                      "Wed, Dec 18, 18.00 - 22.00 PM",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: ThemesStyles.primary),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      size: 18,
                                      color: ThemesStyles.primary,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: SizedBox(
                                        width: 140,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "55000 SYP",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 170, 170, 170),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                    Icon(
                                      widget.isUserLoggedIn
                                          ? Icons.favorite
                                          : null,
                                      size: 18,
                                      color: ThemesStyles.primary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
