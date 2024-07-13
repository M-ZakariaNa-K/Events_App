import 'package:events_app/Investor_App/view/lounges/LoungesDetailsPage.dart';
import 'package:events_app/User_App/components/search/search_taps_widget.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoungesUserPage extends StatelessWidget {
  const LoungesUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loungesController = Get.put(LoungesUserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lounges"),
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
            loungesController.loungesItems.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Obx(() {
        if (loungesController.loangesLoading.value) {
          return const Center(child: MainLoadingWidget());
        }
        if (loungesController.loungesItems.isEmpty) {
          return Center(
            child: Opacity(
              opacity: 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/searchNotFoundImage.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Text(
                      'There are no lounges to show',
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
        } else {
          return HallUserCards(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
          );
        }
      }),
    );
  }
}

class HallUserCards extends GetView<LoungesUserController> {
  HallUserCards({
    super.key,
    required this.width,
    required this.height,
  });

  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    final loungeController = Get.put(LoungesUserController());
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior(),
      child: Obx(
        () => Column(
          children: [
            const Padding(
              padding:
                   EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: SearchTapsWidget(
                isSearch: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: loungeController.loungesItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      print(
                          "imm iddd ${loungeController.loungesItems[index].id}");
                      await loungeController.getloungeDetailsItems(
                        id: loungeController.loungesItems[index].id,
                      );
                      Get.to(() => LoungesDetailsPage(
                            id: loungeController.loungesItems[index].id,
                          ));
                    },
                    child: Container(
                      width: width,
                      height: height / 6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: ThemesStyles.secondary, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(5, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width / 5,
                            child: Image.asset(
                                'assets/images/searchNotFoundImage.png'),

                            // Image.network(
                            //     "http://192.168.1.2:8000/storage/${loungeController.loungesItems[index].photos[0]}"),
                          ).marginSymmetric(horizontal: width * 0.03),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    loungeController.loungesItems[index].id
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemesStyles.primary,
                                      fontSize: ThemesStyles.mainFontSize + 2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ).marginOnly(bottom: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.pin_drop,
                                    color: ThemesStyles.primary,
                                  ),
                                  Text(
                                    loungeController.loungesItems[index].rate
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemesStyles.textColor,
                                      fontSize: ThemesStyles.littelFontSize,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              )
                                  .marginSymmetric(horizontal: 0)
                                  .marginOnly(bottom: 0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.schedule,
                                    color: ThemesStyles.primary,
                                  ),
                                  Text(
                                    loungeController
                                        .loungesItems[index].services[0].name
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemesStyles.textColor,
                                      fontSize: ThemesStyles.littelFontSize - 2,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                    5,
                                    (i) => Icon(
                                          Icons.star,
                                          color: loungeController
                                                      .loungesItems[index]
                                                      .rate >
                                                  i
                                              ? Colors.amber[300]
                                              : const Color.fromARGB(
                                                  255, 220, 220, 220),
                                        )),
                              ),
                            ],
                          ).marginOnly(top: height * 0.02),
                        ],
                      ),
                    ),
                  ).marginOnly(top: 10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
