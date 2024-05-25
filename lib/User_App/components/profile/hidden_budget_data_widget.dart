import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class HiddenBudgetDataWidget extends StatefulWidget {
  HiddenBudgetDataWidget({super.key});

  @override
  State<HiddenBudgetDataWidget> createState() => _HiddenBudgetDataWidgetState();
}

class _HiddenBudgetDataWidgetState extends State<HiddenBudgetDataWidget> {
  late TextEditingController _firstTextEditingController;

  bool _isFirstTextFildEditing = false;
  @override
  void initState() {
    super.initState();
    _firstTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _firstTextEditingController.dispose();
    super.dispose();
  }

  late String _enteredFirstTextFildText = '';
  // Initialize with empty string
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "If you want to add to your budget click here ⬇:",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 165, 165, 165),
          ),
        ),
        _isFirstTextFildEditing
            ? TextField(
                controller: _firstTextEditingController,
                onSubmitted: (value) {
                  setState(() {
                    _isFirstTextFildEditing = false;
                    _enteredFirstTextFildText = value;
                  });
                },
                style: const TextStyle(
                  color: ThemesStyles
                      .textColor, // Set text color when entering input
                ),
                decoration: const InputDecoration(
                  hintText: 'هون الرصيد باخدو من الباك',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff979797),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemesStyles.textColor,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0, // Adjust vertical padding
                    horizontal: 10.0, // Adjust horizontal padding
                  ),
                  // Set custom height
                  isDense: true,
                ),
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    _isFirstTextFildEditing = true;
                  });
                },
                child: _enteredFirstTextFildText.isNotEmpty
                    ? Text(
                        _enteredFirstTextFildText,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ThemesStyles.textColor,
                        ),
                      )
                    : const Text(
                        '2400\$',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ThemesStyles.textColor,
                        ),
                      ),
              ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffFAFAFA),
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 206, 206, 206)),
            borderRadius: BorderRadius.circular(
              ThemesStyles.borderradiusprimary,
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Left to spend",
                      style: TextStyle(
                        fontSize: ThemesStyles.littelFontSize,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Monthly budget",
                      style: TextStyle(
                        fontSize: ThemesStyles.littelFontSize,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              //===============================
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "2400\$",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ThemesStyles.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "20,490\$",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ThemesStyles.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
