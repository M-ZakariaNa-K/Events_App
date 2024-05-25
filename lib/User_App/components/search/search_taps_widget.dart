
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class SearchTapsWidget extends StatefulWidget {
  SearchTapsWidget({super.key});

  @override
  State<SearchTapsWidget> createState() => _SearchTapsWidgetState();
}

class _SearchTapsWidgetState extends State<SearchTapsWidget> {
  int? selectedCardIndex;

  final List<String> items = ["All", "Location", "Number"];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        int currentIndex = items.indexOf(item);
        bool isSelected = selectedCardIndex == currentIndex;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCardIndex = currentIndex;
            });
            //Here will change the page data
            if (selectedCardIndex == 0) {
            } else if (selectedCardIndex == 1) {
            } else {}
          },
          child: Container(
            width: 70,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
                color: isSelected ? ThemesStyles.primary : Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: isSelected
                    ? null
                    : Border.all(color: ThemesStyles.primary, width: 1)),
            child: Center(
                child: Text(
              item,
              style: TextStyle(
                color: isSelected
                    ? ThemesStyles.seconndTextColor
                    : ThemesStyles.primary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        );
      }).toList(),
    );
  }
}
