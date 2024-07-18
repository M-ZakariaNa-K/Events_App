import 'package:events_app/User_App/controllers/Favorates/Favorate_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoratePage extends GetView<FavorateController> {
  const FavoratePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.put(FavorateController());
    return Obx(() {
      if (favoriteController.favoriteItemsLoading.value) {
        return const MainLoadingWidget();
      }

      if (favoriteController.favoriteItems.isEmpty) {
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
                    'There are no favorites to show',
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

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: favoriteController.favoriteItems.length,
          itemBuilder: (context, i) {
            var item = favoriteController.favoriteItems[i];

            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
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
                        image: AssetImage("assets/images/ballons.jpeg"),
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  item.organizerName ?? item.name ?? "zzz",
                                  style: TextStyle(
                                    fontSize: ThemesStyles.mainFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                item.organizerName != null
                                    ? " Organizer"
                                    : " Lounge",
                                style: TextStyle(
                                    fontSize: ThemesStyles.littelFontSize,
                                    color: const Color.fromARGB(
                                        255, 199, 199, 199)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: item.rate > index
                                      ? Colors.amber[300]
                                      : const Color.fromARGB(
                                          255, 220, 220, 220),
                                );
                              }),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: ThemesStyles.primary,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                width: 140,
                                child: Text(
                                  item.address ??
                                      "${item.startTime} - ${item.endTime}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                favoriteController.deleteFavoriteItem(item.id);
                              },
                              child: const Icon(
                                Icons.favorite,
                                size: 18,
                                color: ThemesStyles.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
