import 'package:events_app/common/Util/slide_to_page_route.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/view/first_open/onBoading/first_boading.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _smallCircleController;
  late AnimationController _restCirclesController;
  late Animation<double> _smallCircleAnimation;
  late Animation<double> _restCirclesanimation;
  late Animation<double> _opacityAnimation;
  void navigate({required BuildContext context}) {}
  @override
  void initState() {
    super.initState();

    // =====================================Create an animation controller=====================================
    _smallCircleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _restCirclesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    // =====================================Initialize _smallCircleAnimation=====================================
    _smallCircleAnimation = CurvedAnimation(
      parent: _smallCircleController,
      curve: Curves.easeInOut,
    );
    _restCirclesanimation =
        Tween<double>(begin: 1.0, end: 12).animate(_restCirclesController);
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_smallCircleController);
    // =====================================Start the scaling animation=====================================
    _smallCircleController.forward(from: 0);
    // =====================================Delay the start of _restCirclesController=====================================
    Future.delayed(const Duration(milliseconds: 1100), () {
      _restCirclesController.forward(from: 0.0);
    });
    //Go to Boading() by replacing homepage() to the real name of class
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        SlidToPage(
          page: const FirstBoading(),
          onComplete: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const FirstBoading()));
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemesStyles.primary,
        body: Stack(
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _smallCircleAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.scale(
                      scale: _smallCircleAnimation.value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            100), // Half of container width/height for perfect circle
                        child: SizedBox(
                          width: 160,
                          height: 160,
                          child: Image.asset(
                            "assets/images/Logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //2
            Center(
              child: AnimatedBuilder(
                  animation: _restCirclesanimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _restCirclesanimation.value,
                      child: const CircleWidget(
                        width: 180,
                        height: 180,
                        color: Color(0xffFFFFFF),
                        borderWidth: 20,
                      ),
                    );
                  }),
            ),

            //3
            Center(
              child: AnimatedBuilder(
                  animation: _restCirclesanimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _restCirclesanimation.value,
                      child: CircleWidget(
                        width: 230,
                        height: 230,
                        color: Colors.white.withOpacity(.7),
                        borderWidth: 30,
                      ),
                    );
                  }),
            ),
            //4
            Center(
              child: AnimatedBuilder(
                  animation: _restCirclesanimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _restCirclesanimation.value,
                      child: CircleWidget(
                        width: 300,
                        height: 300,
                        color: Colors.white.withOpacity(.2),
                        borderWidth: 40,
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}

class CircleWidget extends StatelessWidget {
  const CircleWidget(
      {super.key,
      required this.width,
      required this.borderWidth,
      required this.height,
      required this.color});
  final double width;
  final double borderWidth;
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: color),
        borderRadius: BorderRadius.circular(500),
      ),
    );
  }
}
