  import 'package:flutter/material.dart';
  // import 'package:homepage/Anuj/HomePage.dart';
  import '../Kaushal/Found Page/found_list.dart';
import '../Kaushal/Lost Page/lost_list.dart';
  import 'HomePage.dart';
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
                  transform: Matrix4.identity()..scale(selectedIndex == index ? 1.2 : 1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        navItems[index]['icon'],
                        color: selectedIndex == index ? Colors.white : Colors.white54,
                        size: 30,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        navItems[index]['label'],
                        style: TextStyle(
                          color: selectedIndex == index ? Colors.white : Colors.white54,
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
