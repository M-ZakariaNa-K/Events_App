import 'package:events_app/User_App/components/search/search_bar_widget.dart';
import 'package:events_app/User_App/components/search/search_taps_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isGridView = false;
  bool isTheResultPublicEvent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
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
        padding: EdgeInsets.symmetric(horizontal: ThemesStyles.paddingprimary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //=================Search Bar================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Icon(Icons.arrow_back_ios_new_rounded),
                SearchBarWidget(),
              ],
            ),
            //=================Taps================
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0),
              child: SearchTapsWidget(isSearch: true,),
            ),
            //=================Number of found================
            //sEARCH result
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "0 found",
                    style: TextStyle(
                      fontSize: ThemesStyles.mainFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.apps_rounded,
                      color: isGridView ? ThemesStyles.primary : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isGridView = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.line_weight_sharp,
                      color: !isGridView ? ThemesStyles.primary : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isGridView = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            //=================Body================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: isGridView ? _buildGridView() : _buildListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, i) {
        return Container(
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
                          isTheResultPublicEvent
                              ? "Wed, Dec 18, 18.00 - 22.00 PM"
                              // Here the description of the lounge
                              : "Our Lounge has a lot of features",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ThemesStyles.primary),
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: ThemesStyles.primary,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 140,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "Damascus- syria",
                              style: TextStyle(
                                color: Color.fromARGB(255, 170, 170, 170),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                        Icon(
                          Icons.favorite,
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
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4.5,
      ),
      itemBuilder: (context, i) {
        return Container(
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
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                margin: const EdgeInsets.symmetric(horizontal: 5),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          "International Concert",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ThemesStyles.mainFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          isTheResultPublicEvent
                              ? "Wed, Dec 18, 18.00 - 22.00 PM"
                              : "Our Lounge has a lot of features",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ThemesStyles.primary),
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: ThemesStyles.primary,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "Damascus- syria",
                              style: TextStyle(
                                color: Color.fromARGB(255, 170, 170, 170),
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.favorite,
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
        );
      },
    );
  }
}
