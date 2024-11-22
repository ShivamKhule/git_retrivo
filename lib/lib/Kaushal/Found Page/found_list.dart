import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Anuj/FoundModel.dart';
import '../Category/category_description.dart';
// import '../Decription Page/description.dart';
import '../Decription Page/description_ui.dart'; // Assuming this is where you show the details
import 'Found_Model.dart';
import 'package:git_retrivo/lib/Kaushal/Category/category_description.dart';

List<FoundModel> foundCards = [];
List<FoundModel> filteredCards = [];

class FoundPage extends StatefulWidget {
  const FoundPage({super.key});

  @override
  State<FoundPage> createState() => _FoundPageState();
}

/*
class _FoundPageState extends State<FoundPage> {
  TextEditingController searchController = TextEditingController();

  void load() async {
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("foundItemsInfo").get();

    foundCards.clear();
    for (var value in response.docs) {
      foundCards.add(
        FoundModel(
          id: value.id,
          name: value['itemName'],
          category: value['category'],
          date: value['date'],
          location: value['location'],
          description: value['description'],
          url: value['foundImg'],
          number: value['mobileNumber'],
        ),
      );
    }

    setState(() {
      filteredCards = List.from(foundCards); // Initially, show all items
    });
  }

  @override
  void initState() {
    super.initState();
    load();

    searchController.addListener(() {
      filterSearchResults();
    });
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterSearchResults() {
    String query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredCards = List.from(foundCards); // Reset to original list
      } else {
        filteredCards = foundCards
            .where((item) =>
                item.name.toLowerCase().contains(query) ||
                item.location.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Found Items"),
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
                      // TODO: Implement filter functionality
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: filteredCards.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Always reference filteredCards[index] for correct data
                        FoundModel currentItem = filteredCards[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Pass the specific item to the description page
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => FoundDescription(
                                        index: index, // Pass the item object
                                      ),
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
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Found",
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
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

*/
class _FoundPageState extends State<FoundPage> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode(); // Add FocusNode

  void load() async {
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("foundItemsInfo").get();

    foundCards.clear();
    for (var value in response.docs) {
      foundCards.add(
        FoundModel(
          id: value.id,
          name: value['itemName'],
          category: value['category'],
          date: value['date'],
          location: value['location'],
          description: value['description'],
          url: value['foundImg'],
          number: value['mobileNumber'],
        ),
      );
    }

    setState(() {
      filteredCards = List.from(foundCards); // Initially, show all items
    });
  }

  @override
  void initState() {
    super.initState();
    load();

    searchController.addListener(filterSearchResults);
  }

  void filterSearchResults() {
    String query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredCards = List.from(foundCards); // Reset to original list
        searchFocusNode.unfocus(); // Remove focus if search is cleared
      } else {
        filteredCards = foundCards
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
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Found Items"),
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
                      focusNode: searchFocusNode, // Attach FocusNode
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
                      // TODO: Implement filter functionality
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: filteredCards.length,
                      itemBuilder: (BuildContext context, int index) {
                        FoundModel currentItem = filteredCards[index];
                        return Padding(
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
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Found",
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
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}



/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:homepage/Anuj/FoundModel.dart';
import '../../Anuj/FoundModel.dart';
import '../Decription Page/description_ui.dart';
// import 'Found_Model.dart';

List<FoundModel> foundCards = [];

class FoundPage extends StatefulWidget {
  const FoundPage({super.key});

  @override
  State<FoundPage> createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void load() async {
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection("foundItemsInfo")
        // .orderBy('timestamp', descending: true)
        .get();

    foundCards.clear();

    for (var value in response.docs) {
      // print(value['palyerName']);
      foundCards.add(
        FoundModel(
          id: value.id,
          name: value['itemName'],
          category: value['category'],
          date: value['date'],
          ownerName: value['reporterName'],
          email: value['email'] ?? "No email",
          location: value['location'],
          description: value['description'],
          url: value['foundImg'],
          number: value['mobileNumber'],
        ),
      );
      print(foundCards);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
    print("1");
  }

  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // leading: const Icon(Icons.arrow_back),
          title: const Text("Found Items"),
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
                      // TODO: Implement filter functionality
                    },
                    icon: const Icon(Icons.sort),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: foundCards.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return FoundDescription(index: index);
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // color: cardColor[index % cardColor.length],
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // padding: const EdgeInsets.all(10),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.network(
                                    foundCards[index].url.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  foundCards[index].name,
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
                                    const Icon(Icons.location_on_outlined),
                                    Text(
                                      foundCards[index].location,
                                      style: GoogleFonts.quicksand(
                                        fontSize: screenWidth > 600 ? 13 : 11,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  foundCards[index].date,
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
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              "Found",
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/