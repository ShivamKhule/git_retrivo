// My Reports Screen

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyReport extends StatefulWidget {
  const MyReport({super.key});

  @override
  State createState() => _MyReportState();
}

class _MyReportState extends State<MyReport> {
  // list of lost items
  List<Map<String, String>> lostItems = [
    {
      "title1": "Purse",
      "subtitle1": "purse of blue color with guitar kitchen of pink color",
      "image1": "assets/Gauri/png/purse.jpg",
      "title2": "Water Bottle",
      "subtitle2": "pink color water bottle with printed photo",
      "image2": "assets/Gauri/png/water_bottle.png",
    },
    {
      "title1": "Diary",
      "subtitle1": "brown color leather diary with pen and cover",
      "image1": "assets/Gauri/png/diary.jpg",
      "title2": "Ink pen",
      "subtitle2": "ink pen of black and golden color lost in garden",
      "image2": "assets/Gauri/png/pen.jpg",
    },
  ];

  // list of found items
  List<Map<String, String>> foundItems = [
    {
      "title1": "Wallet",
      "subtitle1": "Brown leather wallet found near the fountain",
      "image1": "assets/Gauri/png/wallet.jpg",
      "title2": "Bag",
      "subtitle2": "Black color backpack found near the xerox shop",
      "image2": "assets/Gauri/png/bagpack.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Size of the AppBar
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 129, 163, 226),
              ),
            ),
          
          title: const Text(
            "My Reports",
            style:
                TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lost Items Section
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Lost Items",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            child:

                // carouselSlider for sliding cards
                CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 250,
                enlargeCenterPage: true,
              ),
              items: lostItems.map((item) {
                return buildCardRow(item);
              }).toList(),
            ),
          ),

          // Divider between Lost and Found items
          const Divider(),

          // Found Items Section
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Found Items",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            child:

                // carouselSlider for sliding cards
                CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 250,
                enlargeCenterPage: true,
              ),
              items: foundItems.map((item) {
                return buildCardRow(item);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardRow(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          // First Card
          Expanded(
            child: Card(
              color: const Color.fromARGB(255, 129, 163, 226),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize.min, // Use minimum size to avoid overflow
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: Image.asset(
                          item["image1"]!,
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        item["title1"]!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1, // Limits text to one line with ellipsis
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Center(
                        child: Text(
                          item["subtitle1"]!,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey),
                          overflow: TextOverflow.ellipsis,
                          maxLines:
                              2, // Limits subtitle to two lines with ellipsis
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8), // Space between two cards
          // Second Card
          Expanded(
            child: Card(
              color: const Color.fromARGB(255, 215, 231, 244),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: Image.asset(
                          item["image2"]!,
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        item["title2"]!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Center(
                        child: Text(
                          item["subtitle2"]!,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
