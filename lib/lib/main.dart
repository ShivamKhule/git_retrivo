
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Anuj/BottomSheetNavigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AppBar(),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  const AppBar({super.key});

  @override
  AppBarState createState() => AppBarState();
}

class AppBarState extends State<AppBar> {


  @override
  Widget build(BuildContext context){
    // return const MyApp();

    return const BottomNavigation();
    
  }
}
