import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class reservatioDetailsPage extends StatelessWidget {
  reservatioDetailsPage({super.key});
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemesStyles.secondary,
        title: const Text('Investor'),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          //هي الواحهة زينة مساويتها
        ],
      ),
    );
  }
}
