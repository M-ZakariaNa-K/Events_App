import 'package:events_app/User_App/controllers/profile/profile_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
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
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromARGB(255, 52, 52, 52)
                : const Color(0xffFAFAFA),
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 206, 206, 206)),
            borderRadius: BorderRadius.circular(
              ThemesStyles.borderradiusprimary,
            ),
          ),
          child: _isFirstTextFildEditing
              ? TextField(
                  controller: _firstTextEditingController,
                  onSubmitted: (value) {
                    setState(() {
                      _isFirstTextFildEditing = false;
                      _enteredFirstTextFildText = "$value SYP";
                      try {
                        DioHelper.post(url: "$baseUrl/auth/add-cart", body: {
                          "money": _firstTextEditingController.text,
                        });
                      } catch (e) {
                        Get.snackbar(
                            "Error", "Somthing get wrong please try again");
                      }
                    });
                  },
                  style: const TextStyle(
                    color: ThemesStyles.textColor,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        '${profileController.profileItems[0].money ?? 0} SYP',
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
                      : Text(
                          '${profileController.profileItems[0].money ?? 0} SYP',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
        ),
      ],
    );
  }
}
