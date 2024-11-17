import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Anuj/BottomSheetNavigation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options:const FirebaseOptions(
//       apiKey:  "AIzaSyCgIopwY_KuRVC-YSWqjkj5xfsM89suLoY",
//       appId: "1:753985048450:android:14ec6e7cd5a9036f05099b",
//        messagingSenderId: "753985048450",
//        projectId: "retrivo-6ea1f",
//       )
//   );
//   runApp(const MainApp());

// }


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: LoginScreen(),
//     );
//   }
// }


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