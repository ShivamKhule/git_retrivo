import 'package:flutter/material.dart';
// import 'package:homepage/Kaushal/Found%20Page/found_list.dart';

import '../Found Page/found_list.dart';
import 'Owner_Details.dart';
import 'found_item_details.dart';

int? globalIndex;

class FoundDescription extends StatefulWidget {
  FoundDescription({super.key, int? index}) {
    globalIndex = index;
  }

  @override
  State<FoundDescription> createState() => _FoundDescriptionState();
      
}

class _FoundDescriptionState extends State<FoundDescription> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: 
      appBar: AppBar(
        title: const Text("Description"),
        // backgroundColor: const Color(0xffbb8493),
        flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue, // Start color
                  Colors.purple, // End color
                ],
              ),
            ),
          ), 
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Mobile",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 300,
                // width: MediaQuery.of(context).size.width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Image.asset(
                  'assets/Kaushal/jpeg/tower.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "View on Map",
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.location_on,
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconContainer(
                      Icons.call_sharp, "Call", Colors.green, () {}),
                  _buildIconContainer(
                      Icons.message, "Message", Colors.orange, () {}),
                  _buildIconContainer(Icons.email, "Email", Colors.red, () {}),
                  _buildIconContainer(Icons.share, "Share", Colors.blue, () {}),
                ],
              ),
              const SizedBox(height: 10),
              DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.blue,
                      tabs: [
                        Tab(
                          child: Text(
                            "Item Details",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Finder",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 400, // Adjust height as needed
                      child: TabBarView(
                        children: [
                          ItemDetails(temp: foundCards,index : globalIndex ?? 0),
                          const OwnerDetails(),
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

  Widget _buildIconContainer(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 24),
                Text(
                  label,
                  style: TextStyle(
                      color: color, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}