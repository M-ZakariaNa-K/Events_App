import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/services_user_controller.dart';
import 'package:events_app/User_App/controllers/search/search_cntroller.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:get/get.dart';

class SearchTapsWidget extends StatefulWidget {
  const SearchTapsWidget({
    Key? key,
    required this.isSearch,
    required this.isComeFromOrganizerPage,
  }) : super(key: key);
  final bool isSearch;
  final bool isComeFromOrganizerPage;
  @override
  State<SearchTapsWidget> createState() => _SearchTapsWidgetState();
}

class _SearchTapsWidgetState extends State<SearchTapsWidget> {
  int? selectedCardIndex;
  int? selectedPriceTapId;
  List<Map<String, dynamic>> priceTaps = [];
  bool showPriceTaps = false;

  final List<String> items = ["✅ All", "💶 Rate", "🧮 Price"];
  final List<String> searchItems = ["✅ Name", "💶 Address", "🧮 Capacity"];

  @override
  void initState() {
    super.initState();
    // Set the default selected card to be the first item (All)
    selectedCardIndex = 0;
  }

  Future<void> fetchPriceTaps() async {
    try {
      // Fetch the data from the API
      Map<String, dynamic> data =
          await DioHelper.get(url: '$baseUrl/service/list?identifier=all');
      setState(() {
        priceTaps = List<Map<String, dynamic>>.from(data["data"]);
        showPriceTaps = true;
      });
    } catch (e) {
      print("Error fetching price taps: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: widget.isSearch
              ? searchItems.map((item) {
                  int currentIndex = searchItems.indexOf(item);
                  bool isSelected = selectedCardIndex == currentIndex;
                  return GestureDetector(
                    onTap: () async {
                      final searchController = Get.put(SearchUserController());
                      setState(() {
                        selectedCardIndex = currentIndex;
                        sharedSelectedSearchIdentifier = selectedCardIndex!;
                        print(
                            'sharedSelectedSearchIdentifier: ${sharedSelectedSearchIdentifier}');
                      });

                      if (selectedCardIndex == 0) {
                        if (isUser) {
                          // Here make the request of search For USER
                          // searchController.searchItems.clear();
                          // await searchController.getSearchItems(
                          //     identifier: "name", value: "");
                        } else {
                          if (isHallOwner) {
                            // Here make the request of search For HallOwner
                          } else {
                            // Here make the request of search For Organizer
                          }
                        }
                      } else if (selectedCardIndex == 1) {
                        if (isUser) {
                          // Here make the request of search For USER
                        } else {
                          if (isHallOwner) {
                            // Here make the request of search For HallOwner
                          } else {
                            // Here make the request of search For Organizer
                          }
                        }
                      } else if (selectedCardIndex == 2) {
                        if (isUser) {
                          // Here make the request of search For USER
                        } else {
                          if (isHallOwner) {
                            // Here make the request of search For HallOwner
                          } else {
                            // Here make the request of search For Organizer
                          }
                        }
                      }
                    },
                    child: Container(
                      width: widget.isSearch ? 90 : 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ThemesStyles.primary
                            : Colors.transparent,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: isSelected
                            ? null
                            : Border.all(color: ThemesStyles.primary, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: isSelected
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList()
              : items.map((item) {
                  int currentIndex = items.indexOf(item);
                  bool isSelected = selectedCardIndex == currentIndex;
                  return GestureDetector(
                    onTap: () async {
                      // Update the selected tab
                      setState(() {
                        selectedCardIndex = currentIndex;
                      });

                      // Perform the necessary actions based on the selected tab
                      if (selectedCardIndex == 0) {
                        setState(() {
                          showPriceTaps = false;
                        });
                        if (widget.isSearch) {
                          // Here make the request of search

                          if (widget.isComeFromOrganizerPage) {
                            // Handle organizer-specific logic
                            final organizerController =
                                Get.put(ServicesUserController());
                            organizerController.servicesItems.clear();
                            await organizerController.getServicesItems(
                              role: "Organizer",
                              service_id: null,
                              identifier: "all",
                            );
                          } else {
                            final loungeController =
                                Get.put(LoungesUserController());
                            // Clear the stored data and fetch new data from the API
                            loungeController.loungesItems.clear();
                            await loungeController.getloungesItems(
                              role: "HallOwner",
                              service_id: null,
                              identifier: "all",
                            );
                          }
                        }
                      } else if (selectedCardIndex == 1) {
                        setState(() {
                          showPriceTaps = false;
                        });
                        if (widget.isSearch) {
                          // Here make the request of search
                        } else {
                          if (widget.isComeFromOrganizerPage) {
                            // Handle organizer-specific logic
                            final organizerController =
                                Get.put(ServicesUserController());
                            organizerController.servicesItems.clear();
                            await organizerController.getServicesItems(
                              role: "Organizer",
                              service_id: null,
                              identifier: "rate",
                            );
                          } else {
                            final loungeController =
                                Get.put(LoungesUserController());
                            loungeController.loungesItems.clear();
                            await loungeController.getloungesItems(
                              role: "HallOwner",
                              service_id: null,
                              identifier: "rate",
                            );
                          }
                        }
                      } else if (selectedCardIndex == 2) {
                        final loungeController =
                            Get.put(LoungesUserController());
                        // Clear the stored data and fetch new data from the API
                        loungeController.loungesItems.clear();
                        await fetchPriceTaps();
                      }
                    },
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ThemesStyles.primary
                            : Colors.transparent,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: isSelected
                            ? null
                            : Border.all(color: ThemesStyles.primary, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: isSelected
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
        ),
        if (showPriceTaps)
          Stack(
            clipBehavior: Clip.none,
            children: [
              RotatedBox(
                quarterTurns: 90,
                child: Positioned(
                  child: Align(
                    alignment:
                        Alignment.center, // Change alignment based on language
                    child: CustomPaint(
                      size: const Size(40, 20),
                      painter: TrianglePainter(
                          color: ThemesStyles.thirdColor, isRTL: false),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: ThemesStyles.thirdColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Wrap(
                  children: priceTaps.map((tap) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedPriceTapId = tap['id'];
                        });
                        if (widget.isComeFromOrganizerPage) {
                          final organizerController =
                              Get.put(ServicesUserController());
                          organizerController.servicesItems.clear();
                          await organizerController.getServicesItems(
                            role: "Organizer",
                            service_id: selectedPriceTapId,
                            identifier: "price",
                          );
                        }
                        if (!widget.isComeFromOrganizerPage) {
                          final loungeController =
                              Get.put(LoungesUserController());
                          loungeController.loungesItems.clear();
                          await loungeController.getloungesItems(
                            role: "HallOwner",
                            service_id: selectedPriceTapId,
                            identifier: "price",
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: selectedPriceTapId == tap['id']
                              ? ThemesStyles.secondary
                              : Colors.transparent,
                          border: Border.all(
                            color: ThemesStyles.primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          tap['name'],
                          style: TextStyle(
                            color: selectedPriceTapId == tap['id']
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.primary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final bool isRTL;

  TrianglePainter({required this.color, this.isRTL = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isRTL) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(0, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
