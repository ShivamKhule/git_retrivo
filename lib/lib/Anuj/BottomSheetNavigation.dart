
// import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:homepage/Anuj/HomePage.dart';
import '../Kaushal/Found Page/found_list.dart';
import '../Kaushal/Lost Page/lost_list.dart';
// import 'FoundModel.dart';
import 'HomePage.dart';
// import 'LostModel.dart';
import 'ReportFoundItemPage.dart';
import 'ReportLostItemPage.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;

  const BottomNavigation({super.key, this.initialIndex = 0});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  late int selectedIndex;

  // Future<void> load() async {
  //   // foundCards.clear();
  //   // lostCards.clear();

  //   QuerySnapshot response = await FirebaseFirestore.instance
  //       .collection("foundItemsInfo")
  //       .orderBy('timestamp', descending: true)
  //       .get();

  //   for (var value in response.docs) {
  //     foundCards.add(
  //       FoundModel(
  //         id: value.id,
  //         name: value['itemName'],
  //         category: value['category'],
  //         date: value['date'],
  //         location: value['location'],
  //         description: value['description'],
  //         url: value['foundImg'],
  //         number: value['mobileNumber'],
  //       ),
  //     );
  //     print(foundCards);
  //   }

  //   QuerySnapshot responsel = await FirebaseFirestore.instance
  //       .collection("lostItemsInfo")
  //       .orderBy('timestamp', descending: true)
  //       .get();

  //   // log(response as String);

  //   for (var value in responsel.docs) {
  //     // print(value['palyerName']);
  //     try {
  //       lostCards.add(
  //         LostModel(
  //           id: value.id,
  //           name: value['itemName'] ?? "Unknown",
  //           category: value['category'] ?? "Uncategorized",
  //           date: value['date'] ?? "Unknown date",
  //           location: value['location'] ?? "Unknown location",
  //           description: value['description'] ?? "No description",
  //           mapLocation: value['mapLocation'] ?? "Location not given",
  //           number: value['mobileNumber'] ?? "No number",
  //           url: value['lostImg'] ?? "",

  //           billurl: value['billImg'].isEmpty ? "" : value["billImg"],
  //           // reward: value['reward'] ?? 0,
  //           reward: value['reward'].isEmpty ? "No Reward" : value['reward'],
  //         ),
  //       );
  //     } catch (e) {
  //       log("Error processing document ${value.id}: $e");
  //     }
  //   }

  //   // setState(() {});
  // }

  final List<Widget> navPages = [
    const HomepageClass(),
    const ReportLostItemPage(),
    const ReportFoundItemPage(),
    // const LostItemsPage(),
    const LostPage(),
    // const FoundItemsPage(),
    const FoundPage(),
  ];

  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.report_problem, 'label': 'Report Lost'},
    {'icon': Icons.add_alert, 'label': 'Report Found'},
    {'icon': Icons.search, 'label': 'Lost Items'},
    {'icon': Icons.find_in_page, 'label': 'Found Items'},
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    // load();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: navPages,
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(navItems.length, (index) {
            return GestureDetector(
              onTap: () => onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.identity()
                  ..scale(selectedIndex == index ? 1.2 : 1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      navItems[index]['icon'],
                      color: selectedIndex == index
                          ? Colors.white
                          : Colors.white54,
                      size: 30,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      navItems[index]['label'],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
