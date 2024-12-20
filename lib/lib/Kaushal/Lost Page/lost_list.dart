import 'dart:developer';

import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Anuj/LostModel.dart';
import '../Category/category_description.dart';
// import './Lost_Model.dart';

List<LostModel> lostCards = [
  // LostModel(
  //     id: "1",
  //     name: "Laptop",
  //     category: "Electronics",
  //     date: "18 JULY,2024",
  //     location: "Mumbai",
  //     description:
  //         "Widgets, AppBar, NavBar, GestureDtector, List, TextEditingController",
  //     number: "98765400"),
  // LostModel(
  //     id: "2",
  //     name: "Bag",
  //     category: "Clothing And Accessories",
  //     date: "20 JULY,2024",
  //     location: "Pune",
  //     description:
  //         "Widgets, AppBar, NavBar, GestureDtector, List, TextEditingController",
  //     number: "98765400"),
  // LostModel(
  //     id: "3",
  //     name: "Mobile",
  //     category: "Transportation",
  //     date: "15 JULY,2024",
  //     location: "Pune",
  //     description:
  //         "Widgets, AppBar, NavBar, GestureDtector, List, TextEditingController",
  //     number: "98765400"),
];

class LostPage extends StatefulWidget {
  const LostPage({super.key});

  @override
  State<LostPage> createState() => _LostPageState();
}


class _LostPageState extends State<LostPage> {
  double screenWidth = 0;

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode(); // Focus for the search bar
  List<LostModel> filteredCards = []; // Filtered list for search results

  void load() async {
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("lostItemsInfo").get();

    lostCards.clear();
    for (var value in response.docs) {
      try {
        lostCards.add(
          LostModel(
            id: value.id,
            ownerName: value['ownerName'],
            name: value['itemName'] ?? "Unknown",
            category: value['category'] ?? "Uncategorized",
            date: value['date'] ?? "Unknown date",
            location: value['location'] ?? "Unknown location",
            description: value['description'] ?? "No description",
            mapLocation: value['mapLocation'] ?? "Location not given",
            email: value['ownerEmail'] ?? "No email",
            number: value['mobileNumber'] ?? "No number",
            url: value['lostImg'] ?? "",
            billurl: value['billImg'].isEmpty ? "" : value["billImg"],
            reward: value['reward'].isEmpty ? "No Reward" : value['reward'],
          ),
        );
      } catch (e) {
        log("Error processing document ${value.id}: $e");
      }
    }

    setState(() {
      filteredCards = List.from(lostCards); // Show all items initially
    });
  }
  @override
  void initState() {
    super.initState();
    load();
    searchController.addListener(filterSearchResults);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     // startAnimation = true;
    //     filteredCards = List.from(lostCards);
    //   });
    // });
  }


  void filterSearchResults() {
    String query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredCards = List.from(lostCards); // Reset to original list
        searchFocusNode.unfocus(); // Remove focus if search is cleared
      } else {
        filteredCards = lostCards
            .where((item) =>
                item.name.toLowerCase().contains(query) ||
                item.location.toLowerCase().contains(query))
            .toList();
      }
    });
  }


  @override
  void dispose() {
    searchController.dispose(); // Dispose TextEditingController
    searchFocusNode.dispose(); // Dispose FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Lost Items"),
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Search items...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color(0xfff1f1f1),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      // TODO: Add filter functionality
                    },
                    icon: const Icon(Icons.sort),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredCards.isEmpty
                  ? const Center(
                      child: Text(
                        "No items found.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: filteredCards.length,
                      itemBuilder: (BuildContext context, int index) {
                        LostModel currentItem = filteredCards[index];
                        return item(filteredCards[index], index);
                         /*return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          // FoundDescription(
                                          //   index: index,
                                          // ),
                                          DescriptionPage(
                                              index: index,
                                              // citem: item,
                                              filterItems: filteredCards),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 224, 241, 255),
                                        Color.fromARGB(255, 249, 225, 254),
                                      ],
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 10),
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Image.network(
                                            currentItem.url.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          currentItem.name,
                                          style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                screenWidth > 600 ? 18 : 14,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.location_on_outlined),
                                            Text(
                                              currentItem.location,
                                              style: GoogleFonts.quicksand(
                                                fontSize:
                                                    screenWidth > 600 ? 13 : 11,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          currentItem.date,
                                          style: GoogleFonts.quicksand(
                                            fontSize:
                                                screenWidth > 600 ? 14 : 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 20,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Lost",
                                      style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      */
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
// }

   Widget item(LostModel currentItem, int index) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      // transform:
      //     Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      duration: Duration(milliseconds: 300 + (index * 100)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DescriptionPage(
                  index: index,
                  filterItems: filteredCards,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 224, 241, 255),
                      Color.fromARGB(255, 249, 225, 254),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.network(
                          currentItem.url.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentItem.name,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth > 600 ? 18 : 14,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 16),
                          Flexible(
                            child: Text(
                              currentItem.location,
                              style: GoogleFonts.quicksand(
                                fontSize: screenWidth > 600 ? 13 : 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        currentItem.date,
                        style: GoogleFonts.quicksand(
                          fontSize: screenWidth > 600 ? 14 : 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 20,
                  width: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      "Lost",
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*class _LostPageState extends State<LostPage> {
  double screenWidth = 0;

  void load() async {
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("lostItemsInfo").get();

    // log(response as String);
    lostCards.clear();
    for (var value in response.docs) {
      // print(value['palyerName']);
      try {
        lostCards.add(
          LostModel(
            id: value.id,
            ownerName: value['ownerName'],
            name: value['itemName'] ?? "Unknown",
            category: value['category'] ?? "Uncategorized",
            date: value['date'] ?? "Unknown date",
            location: value['location'] ?? "Unknown location",
            description: value['description'] ?? "No description",
            mapLocation: value['mapLocation'] ?? "Location not given",
            email: value['email'] ?? "No email",
            number: value['mobileNumber'] ?? "No number",
            url: value['lostImg'] ?? "",
            billurl: value['billImg'].isEmpty ? "" : value["billImg"],
            reward: value['reward'].isEmpty ? "No Reward" : value['reward'],
          ),
        );
      } catch (e) {
        log("Error processing document ${value.id}: $e");
      }
      // log(lostCards as String);

      setState(() {});
    }
    // BottomSheet for filter functionality (to be implemented)
  }

  bool startAnimation = false;

  List cardColor = [
    const LinearGradient(
      colors: [
        Colors.blue,
        Colors.purple,
      ],
    ),
    const LinearGradient(
      colors: [
        Colors.green,
        Colors.blue,
      ],
    ),
    const LinearGradient(
      colors: [
        Colors.pink,
        Colors.orange,
      ],
    ),
    const LinearGradient(
      colors: [
        Colors.yellow,
        Color.fromARGB(255, 62, 255, 223),
      ],
    ),
  ];

  List<Widget> img = [
    Image.asset(
      "assets/Kaushal/jpeg/ship.jpg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/Kaushal/jpeg/mobile.jpg",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/Kaushal/jpeg/tower.jpg",
      fit: BoxFit.cover,
    ),
  ];

  @override
  void initState() {
    super.initState();
    load();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
        //
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // filterSheet();
    screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2;
    print(lostCards.length);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // leading: const Icon(Icons.arrow_back),
          title: const Text("Lost Items"),
          centerTitle: true,
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
          ), //const Color(0xffbb8493),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      // controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search items...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color(0xfff1f1f1),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      // filterSheet();
                    },
                    icon: const Icon(Icons.sort),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: lostCards.length,
                itemBuilder: (BuildContext context, int index) {
                  return item(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(int index) {
    // double imageSize = screenWidth > 600 ? 100 : 80; // Responsive image size

    return AnimatedContainer(
      curve: Curves.easeInOut,
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      duration: Duration(milliseconds: 300 + (index * 100)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  // color: cardColor[index % cardColor.length],
                  // gradient: cardColor[index % cardColor.length],
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 224, 241, 255),
                      Color.fromARGB(255, 249, 225, 254),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return //DescriptionPage(index: index);
                                DescriptionPage(
                              index: index,
                              // citem: item,
                              //filterItems: filteredCards
                            );
                          }));
                        },
                        child: Container(
                          // padding: const EdgeInsets.all(10),
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.network(
                            lostCards[index].url.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        lostCards[index].name,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth > 600 ? 18 : 14,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 16),
                          Flexible(
                            child: Text(
                              lostCards[index].location,
                              style: GoogleFonts.quicksand(
                                fontSize: screenWidth > 600 ? 13 : 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        lostCards[index].date,
                        style: GoogleFonts.quicksand(
                          fontSize: screenWidth > 600 ? 14 : 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // margin: const EdgeInsets.all(10),
                  height: 20,
                  width: 50,
                  // color: Colors.red,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      "Lost",
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


*/
