import 'package:flutter/material.dart';
import 'package:git_retrivo/lib/Kaushal/Category/category_list.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Decription Page/Owner_Details.dart';
import '../Decription Page/found_item_details.dart';
import '../Lost Page/lost_list.dart';
import '../Found Page/found_list.dart';
// import 'Item_Details.dart';
// import 'Owner_Details.dart';

int? globalIndex;

class DescriptionPage extends StatefulWidget {
  DescriptionPage({super.key, int? index}) {
    globalIndex = index; // Assign the index of the clicked item
  }

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    // Choose the correct list and item based on the global category
    final isLost = globalCategory == "Lost";
    final currentItem = isLost ? lostCards[globalIndex ?? 0] : foundCards[globalIndex ?? 0];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Description"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.purple,
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Display the item's image
              Container(
                height: 300,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                // child: Image.network(
                //   currentItem.url.toString(),
                //   fit: BoxFit.contain,
                // ),
              ),
              const SizedBox(height: 10),
              // View on Map button
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
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconContainer(Icons.call_sharp, "Call", Colors.green, () {}),
                  _buildIconContainer(Icons.message, "Message", Colors.orange, () {}),
                  _buildIconContainer(Icons.email, "Email", Colors.red, () {}),
                  _buildIconContainer(Icons.share, "Share", Colors.blue, () {}),
                ],
              ),
              const SizedBox(height: 10),
              // Tab Bar for Item Details and Owner Details
              DefaultTabController(
                length: 2,
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
                            "Owner",
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
                          // Pass details to the respective tabs
                          ItemDetails(temp: isLost ? lostCards : foundCards, index: globalIndex ?? 0),
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

  // Utility method to build action buttons
  Widget _buildIconContainer(IconData icon, String label, Color color, VoidCallback onTap) {
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
