import 'package:events_app/common/Util/lang_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class OrderNowCardWidget extends StatefulWidget {
  @override
  _OrderNowCardWidgetState createState() => _OrderNowCardWidgetState();
}

class _OrderNowCardWidgetState extends State<OrderNowCardWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
    _controller?.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (_controller?.status == AnimationStatus.completed) {
              _controller?.reverse();
            } else {
              _controller?.forward();
            }
          },
          child: AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 - (_animation!.value * 0.03),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child:
                      
                          Stack(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(
                                  children: [
                                    Opacity(
                                      opacity: 0.5,
                                      child: Image.asset(
                                        'assets/images/OffersCardBackgroundGraident.jpeg',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 200,
                                      ),
                                    ),
                                    //===================the Left Icon and its text===============
                                    Positioned(
                                      top: 20,
                                      left: LanguageRadioController()
                                              .selectedValue
                                          ? 10
                                          : 0,
                                      // right: LanguageRadioController()
                                      //         .selectedValue
                                      //     ? 0
                                      //     : 10,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            ThemesStyles.paddingprimary),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              0), // Half of container width/height for perfect circle
                                          child: SizedBox(
                                            width: 150,
                                            height: 150,
                                            child: Image.asset(
                                              "assets/images/planner.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //===================eND the Left Icon and its text===============
                                    //===================Start the TAG ===============
                                    Positioned(
                                      top: 30,
                                      // left: LanguageRadioController()
                                      //         .selectedValue
                                      //     ? 0
                                      //     : 20,
                                      right: LanguageRadioController()
                                              .selectedValue
                                          ? 20
                                          : 0,
                                      child: GestureDetector(
                                        onTap: () {
//here we go to the offers page
                                        },
                                        child: SizedBox(
                                          width: 170,
                                          child: Text(
                                            'Are you loking for publec or private event? What are you wating for! Book Now',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  ThemesStyles.mainFontSize - 2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //===================End the TAG ===============
                                    //===================Start the see offers ===============

                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Opacity(
                                        opacity: 1
                                        // - _animation!.value,
                                        ,
                                        child: MaterialButton(
                                          onPressed: () {},
                                          color: ThemesStyles.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'Book Now',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            },
          ),
        ),
        //====================== Balloons=======================
        // AnimatedPositioned(
        //   duration: Duration(seconds: 5),
        //   left: 50,
        //   top: 20,
        //   child: Image.asset(
        //     'assets/images/ballons.jpeg',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // AnimatedPositioned(
        //   duration: const Duration(seconds: 4),
        //   right: 80,
        //   top: 50,
        //   child: Image.asset(
        //     'assets/images/ballons.jpeg',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // AnimatedPositioned(
        //   duration: Duration(seconds: 3),
        //   left: 120,
        //   top: 80,
        //   child: Image.asset(
        //     'assets/images/ballons.jpeg',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // // People
        // AnimatedPositioned(
        //   duration: Duration(seconds: 10),
        //   right: 20,
        //   bottom: 20,
        //   child: Image.asset(
        //     'assets/images/person.png',
        //     width: 50,
        //     height: 100,
        //   ),
        // ),
        // AnimatedPositioned(
        //   duration: Duration(seconds: 8),
        //   left: 20,
        //   bottom: 40,
        //   child: Image.asset(
        //     'assets/images/person.png',
        //     width: 0,
        //     height: 100,
        //   ),
        // ),
      ],
    );
  }
}
