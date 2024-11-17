// Login Page

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:homepage/Anuj/BottomSheetNavigation.dart';
import 'package:rive/rive.dart';
import '../Anuj/BottomSheetNavigation.dart';
import 'forgot_password.dart';
import 'sign_up.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  StateMachineController? stateMachineController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationURL = defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS
        ? 'assets/Gauri/riv/bear.riv'
        : 'riv/bear.riv';
    rootBundle.load(animationURL).then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          for (var e in stateMachineController!.inputs) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          }

          for (var element in stateMachineController!.inputs) {
            if (element.name == "trigSuccess") {
              successTrigger = element as SMITrigger;
            } else if (element.name == "trigFail") {
              failTrigger = element as SMITrigger;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          }
        }

        setState(() => _teddyArtboard = artboard);
      },
    );
  }

  void handsOnTheEyes() {
    isHandsUp?.change(true);
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    numLook?.change(val.length.toDouble());
  }

  void login() {
    // Hide any animations related to checking
    isChecking?.change(false);
    isHandsUp?.change(false);

    // Validation for empty fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Show a SnackBar if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both email and password"),
          backgroundColor: Colors.red,
        ),
      );
      // Trigger the failure animation if fields are empty
      failTrigger?.fire();
      return; // Exit the function without proceeding further
    }

    // Check credentials and trigger success or failure animation
    if (_emailController.text == "Gauri" &&
        _passwordController.text == "1234") {
      successTrigger?.fire();

      // Delay navigation slightly to allow the success animation to play
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
        );
      });
    } else {
      // Trigger failure animation if credentials are incorrect
      failTrigger?.fire();
    }
  }


    // function to add custom Textstyle
  TextStyle customTextStyle(double fontSize, Color color,
      {FontWeight fontWeight = FontWeight.normal}) {
    return GoogleFonts.quicksand(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 226, 234),
      appBar:  PreferredSize(
        preferredSize: const Size(100, 80),
        child: AppBar(
            title: Text(
              "Login Page",
              style: customTextStyle(28, Colors.white, fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 129, 163, 226),
          ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_teddyArtboard != null)
                  SizedBox(
                    width: 380,
                    height: 280,
                    child: Rive(
                      artboard: _teddyArtboard!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                Container(
                  alignment: Alignment.center,
                  width: 350,
                  padding: const EdgeInsets.only(bottom: 15),
                  margin: const EdgeInsets.only(bottom: 15 * 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const SizedBox(height: 15 * 2),
                            TextField(
                              controller: _emailController,
                              onTap: lookOnTheTextField,
                              onChanged: moveEyeBalls,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 14),
                              cursorColor: const Color(0xffb04863),
                              decoration: const InputDecoration(
                                hintText: "Email/Username",
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusColor: Color(0xffb04863),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffb04863),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: _passwordController,
                              onTap: handsOnTheEyes,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              style: const TextStyle(fontSize: 14),
                              cursorColor: const Color(0xffb04863),
                              decoration: const InputDecoration(
                                hintText: "Password",
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusColor: Color(0xffb04863),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffb04863),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 40,
                              width: 300,
                              child: ElevatedButton(
                                  onPressed: login,
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 192, 217, 237))
                                  ),
                                  child: Text(
                                    "Login",
                                    style:customTextStyle(20, const Color.fromARGB(255, 104, 111, 241),fontWeight: FontWeight.w600) ,
                                  )),
                            ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ForgotPassword()));
                            },
                            child: Text("forgot password ?",
                                style: customTextStyle(
                                    15, const Color.fromARGB(255, 104, 111, 241),
                                    fontWeight: FontWeight.w600)),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()));
                            },
                            child: Text("New user?\nCreate account here..",
                                style: customTextStyle(
                                    15, const Color.fromARGB(255, 104, 111, 241),
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
        ),
      );
  }
}
