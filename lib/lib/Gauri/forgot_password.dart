import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'login_page.dart';

class MyApp6 extends StatelessWidget {
  const MyApp6({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPassword(),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  String? email;

  late RiveAnimationController _riveController;

  @override
  void initState() {
    super.initState();

    // Initialize the Rive controller to play the animation
    
    _riveController = SimpleAnimation("playing_panda.riv"); 
     _riveController.isActive = true;
  }



  // Function to create custom border
  OutlineInputBorder customBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color, // Border color
        width: 1.8, // Border width
      ),
      borderRadius: BorderRadius.circular(20), // Border radius
    );
  }

  // Function to add custom Text style
  TextStyle customTextStyle(double fontSize, Color color,
      {FontWeight fontWeight = FontWeight.normal}) {
    return GoogleFonts.quicksand(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  // Function for snackbar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: customTextStyle(15, Colors.white, fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.black,
      ),
    );
  }

  // Function for input validation
  bool validInput = true;
  void isvalidInput() {
    validInput = email != null && email!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 226, 234),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Size of the AppBar
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 129, 163, 226),
            ),
          ),
          title: const Text(
            "Forgot Password",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                fontFamily: "Quicksand",
                color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          const MainApp()), // Replace MainApp() with your actual main app widget
                  (Route<dynamic> route) => false,
                );
              }),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only( left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 250,
                height: 250,
                color: const Color.fromARGB(255, 214, 226, 234),
                child: RiveAnimation.asset(
                  'assets/Gauri/riv/playing_panda.riv',
                  controllers: [_riveController],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "Forgot Password",
              style:
                  customTextStyle(28, Colors.blue, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Enter your registered email address, and we will send you a link to reset your password..!!",
              style: customTextStyle(18, Colors.blueGrey,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: customTextStyle(
                      20, const Color.fromARGB(255, 51, 60, 232),
                      fontWeight: FontWeight.w700),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter your registered email:",
                  hintStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 124, 122, 122)),
                  enabledBorder:
                      customBorder(const Color.fromARGB(255, 51, 60, 232)),
                  focusedBorder:
                      customBorder(const Color.fromARGB(255, 51, 60, 232))),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 50,
              width: 230,
              child: ElevatedButton(
                onPressed: () {
                  email = emailController.text.trim();
                  setState(() {
                    emailController.clear();
                    if (email!.isEmpty) {
                      // Check if the email field is empty
                      isvalidInput();
                      _showSnackbar(context, "Please enter valid email..");
                    } else {
                      isvalidInput();
                      _showSnackbar(context, "Link sent successfully..");
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 139, 192, 234),
                ),
                child: const Text(
                  "Send Reset Link",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Resend Link",
                style: customTextStyle(
                    18, const Color.fromARGB(255, 51, 60, 232),
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
