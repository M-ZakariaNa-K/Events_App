import 'package:events_app/User_App/controllers/search/search_cntroller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchUserController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: MediaQuery.sizeOf(context).width - 40,
        height: 55,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff2B2B2B)
              : const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onChanged: (value) async {
            if (sharedSelectedSearchIdentifier == 0) {
              searchController.searchItems.clear();
              
              await searchController.getSearchItems(
                  identifier: "name", value: value);
            } else if (sharedSelectedSearchIdentifier == 1) {
              searchController.searchItems.clear();
              await searchController.getSearchItems(
                  identifier: "address", value: value);
            } else {
              searchController.searchItems.clear();
              await searchController.getSearchItems(
                  identifier: "capacity", value: value);
            }
            if (value == "") {
              searchController.searchItems.clear();
            }
          },
          controller: searchController.searchControllerTextFild,
          decoration: InputDecoration(
              hintText: 'Search for what you want...',
              hintStyle: const TextStyle(
                color: Color(0xffAFAFAF),
              ),
              contentPadding: const EdgeInsets.all(8.0),
              //Start Border of TextFild
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ), // Set your desired border color here
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: ThemesStyles
                        .primary), // Set your desired border color here
                borderRadius: BorderRadius.circular(5.0),
              ),
              //End Border of TextFild
              prefixIcon: Container(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  "assets/images/search.png",
                  color: ThemesStyles.primary,
                ),
              ),
              suffixIcon: const Icon(
                Icons.filter_list_outlined,
                color: ThemesStyles.primary,
              )),
        ),
      ),
    );
  }
}
