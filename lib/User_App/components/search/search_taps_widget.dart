import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class SearchTapsWidget extends StatefulWidget {
  const SearchTapsWidget({super.key});

  @override
  State<SearchTapsWidget> createState() => _SearchTapsWidgetState();
}

class _SearchTapsWidgetState extends State<SearchTapsWidget> {
  int? selectedCardIndex;

  final List<String> items = ["✅ All", "💶 Location", "🧮 Number"];

  @override
  void initState() {
    super.initState();
    // Set the default selected card to be the first item (All)
    selectedCardIndex = 0;
  }

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
            // Here will change the page data
            if (selectedCardIndex == 0) {
              // Code to handle "All" tab selection
            } else if (selectedCardIndex == 1) {
              // Code to handle "Location" tab selection
            } else if (selectedCardIndex == 2) {
              // Code to handle "Number" tab selection
            }
          },
          child: Container(
            width: 80,
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
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        );
      }).toList(),
    );
  }
}
