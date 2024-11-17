
import 'package:flutter/material.dart';
// import 'package:homepage/Gauri/fadeAnimation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';

import 'fadeAnimation.dart';
import 'login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _scale2Controller;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;
  late RiveAnimationController _riveController;

  @override
  void initState() {
    super.initState();

    _riveController = SimpleAnimation("playing_panda.riv");

    _scaleController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: const MainApp()));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 226, 234),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -50,
              left: 0,
              child: FadeAnimation(
                  1,
                  Container(
                    width: width,
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Gauri/png/one.png'),
                            fit: BoxFit.cover)),
                  )),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimation(
                  1.3,
                  Container(
                    width: width,
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Gauri/png/one.png'),
                            fit: BoxFit.cover)),
                  )),
            ),
            Positioned(
              top: -150,
              left: 0,
              child: FadeAnimation(
                  1.6,
                  Container(
                    width: width,
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Gauri/png/one.png'),
                            fit: BoxFit.cover)),
                  )),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 280,
                  height: 280,
                  child: RiveAnimation.asset(
                    'assets/Gauri/riv/playing_panda.riv',
                    controllers: [_riveController],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 330,
                    ),
                    const FadeAnimation(
                        1,
                        Text(
                          "Welcome",
                          style: TextStyle(
                              color: Color.fromARGB(255, 2, 3, 72),
                              fontSize: 50,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    const FadeAnimation(
                        1.3,
                        Text(
                          "Lost something valuable?\nFound something and want to return it?\nYou've come to the right place!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 2, 3, 72),
                              height: 1.4,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      height: 100,
                    ),
                    FadeAnimation(
                        1.6,
                        AnimatedBuilder(
                          animation: _scaleController,
                          builder: (context, child) => Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Center(
                                child: AnimatedBuilder(
                                  animation: _widthController,
                                  builder: (context, child) => Container(
                                    width: _widthAnimation.value,
                                    height: 80,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.blue.withOpacity(.4)),
                                    child: InkWell(
                                      onTap: () {
                                        _scaleController.forward();
                                      },
                                      child: Stack(children: <Widget>[
                                        AnimatedBuilder(
                                          animation: _positionController,
                                          builder: (context, child) => Positioned(
                                            left: _positionAnimation.value,
                                            child: AnimatedBuilder(
                                              animation: _scale2Controller,
                                              builder: (context, child) =>
                                                  Transform.scale(
                                                      scale: _scale2Animation.value,
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .transparent),
                                                        child: hideIcon == false
                                                            ? const Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color:
                                                                    Colors.white,
                                                                size: 35,
                                                              )
                                                            : Container(),
                                                      )),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              )),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
