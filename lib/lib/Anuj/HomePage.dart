// ignore_for_file: file_names

import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:git_retrivo/lib/Kaushal/Found%20Page/found_list.dart';
import 'package:git_retrivo/lib/Kaushal/Lost%20Page/lost_list.dart';
// import 'package:homepage/Shivam/Notifications.dart';
// import 'package:homepage/Shivam/Profile_Page.dart';
import '../Kaushal/Category/category_list.dart';
import '../Shivam/Notifications.dart';
import '../Shivam/Profile_Page.dart';
import './BottomSheetNavigation.dart';
import 'FoundModel.dart';
import 'LostModel.dart';

//For Search Functionality
class ItemSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Display results based on the search query
    return Center(
      child: Text('You searched for: $query'), // Show search results
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions based on the query
    final suggestions = ['Item 1', 'Item 2', 'Item 3']
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query =
                suggestions[index]; // Set the selected suggestion as the query
            showResults(context); // Show the results
          },
        );
      },
    );
  }
}

class Lostpage {
  final List<String> imagesUrls;
  Lostpage({required this.imagesUrls});
}

class Foundpage {
  final List<String> imagesUrls;
  Foundpage({required this.imagesUrls});
}

class HomepageClass extends StatefulWidget {
  const HomepageClass({super.key});

  @override
  State<HomepageClass> createState() => AppbarClassState();
}

class BackgroundDecoration extends StatelessWidget {
  final Widget child;

  const BackgroundDecoration({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFf0f4ff), Color(0xFFd6e3ff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background shapes
          Positioned(
            top: 50,
            left: 30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          // Content widget
          Center(child: child),
        ],
      ),
    );
  }
}

class AppbarClassState extends State<HomepageClass> {
  int notificationCount = 3;

  // For carasouel
  Future<void> load() async {
    // foundCards.clear();
    // lostCards.clear();

    QuerySnapshot response = await FirebaseFirestore.instance
        .collection("foundItemsInfo")
        .orderBy('timestamp', descending: true)
        .get();

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
      print(foundCards);
    }

    QuerySnapshot responsel = await FirebaseFirestore.instance
        .collection("lostItemsInfo")
        .orderBy('timestamp', descending: true)
        .get();

    // log(response as String);

    for (var value in responsel.docs) {
      // print(value['palyerName']);
      try {
        lostCards.add(
          LostModel(
            id: value.id,
            name: value['itemName'] ?? "Unknown",
            category: value['category'] ?? "Uncategorized",
            date: value['date'] ?? "Unknown date",
            location: value['location'] ?? "Unknown location",
            description: value['description'] ?? "No description",
            mapLocation: value['mapLocation'] ?? "Location not given",
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

    setState(() {});
  }

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
    );

    startAutoScrollForFirstGrid();
    startAutoScrollForFirstGrid();

    carasouelTimer = getTimer();

    load();

    super.initState();
  }

  Lostpage lostpage = Lostpage(imagesUrls: [
    foundCards[foundCards.length - 1].url.toString(),
    foundCards[foundCards.length - 2].url.toString(),
    foundCards[foundCards.length - 3].url.toString(),
    foundCards[foundCards.length - 4].url.toString(),
  ]);

  Lostpage foundpage = Lostpage(imagesUrls: [
    lostCards[lostCards.length - 1].url.toString(),
    lostCards[lostCards.length - 2].url.toString(),
    lostCards[lostCards.length - 3].url.toString(),
    lostCards[lostCards.length - 4].url.toString(),
  ]);

  List<String> fieldCategory1 = [
    "assets/anuj/homepage/caterogyimg/electronics.jpg",
    "assets/anuj/homepage/caterogyimg/personalitems.jpg",
    "assets/anuj/homepage/caterogyimg/documents.png",
    "assets/anuj/homepage/caterogyimg/c_a.jpg",
  ];

  List<String> fieldCategory2 = [
    "assets/anuj/homepage/caterogyimg/transportation.jpg",
    "assets/anuj/homepage/caterogyimg/pets.jpg",
    "assets/anuj/homepage/caterogyimg/household.jpg",
    "assets/anuj/homepage/caterogyimg/others.jpg",
  ];

  PageController? pageController;
  int pageNo = 0;
  Timer? carasouelTimer;

  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerRev = ScrollController();
  Timer? autoScrollTimerFirst;
  Timer? autoScrollTimerSecond;
  bool isScrollingForwardFirst = true;
  bool isScrollingForwardSecond = false;

  List pageCategories1 = [
    'Electronics',
    'Personal Items',
    'Documents',
    'Clothing And Accessories',
  ];

  List pageCategories2 = [
    'Transportation',
    'Pets',
    'Household Items',
    'Others',
  ];

  List categories1 = [
    '\nElectronics',
    '\nPersonal',
    '\nDocuments',
    'Accessories',
  ];
  List categories2 = ['\nTransports', '     Pets', '\nHouseholds', '   Others'];

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 5) {
        pageNo = 0;
      }
      pageController?.animateToPage(pageNo,
          duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      pageNo++;
    });
  }

  void startAutoScrollForFirstGrid() {
    const double scrollAmount = 220.0; // Amount to scroll in each step
    const Duration scrollDuration =
        Duration(seconds: 2); // Duration of each scroll
    const Duration pauseDuration =
        Duration(seconds: 1); // Duration of each pause

    autoScrollTimerFirst =
        Timer.periodic(scrollDuration + pauseDuration, (timer) {
      if (scrollController.hasClients) {
        double currentScrollPosition = scrollController.position.pixels;
        double maxScrollExtent = scrollController.position.maxScrollExtent;

        if (isScrollingForwardFirst) {
          if (currentScrollPosition >= maxScrollExtent) {
            // Reverse direction and start scrolling the second grid
            isScrollingForwardFirst = false;
            startAutoScrollForSecondGrid();
          } else {
            scrollController.animateTo(
              currentScrollPosition + scrollAmount,
              duration: scrollDuration,
              curve: Curves.easeInOut,
            );
          }
        } else {
          if (currentScrollPosition <= 0) {
            // Reverse direction
            isScrollingForwardFirst = true;
          } else {
            scrollController.animateTo(
              currentScrollPosition - scrollAmount,
              duration: scrollDuration,
              curve: Curves.easeInOut,
            );
          }
        }
      }
    });
  }

  void startAutoScrollForSecondGrid() {
    if (autoScrollTimerSecond != null) {
      return; // Prevent starting multiple timers
    }

    const double scrollAmount = 180.0; // Amount to scroll in each step
    const Duration scrollDuration =
        Duration(seconds: 3); // Duration of each scroll

    autoScrollTimerSecond = Timer.periodic(scrollDuration, (timer) {
      if (scrollControllerRev.hasClients) {
        double currentScrollPosition = scrollControllerRev.position.pixels;
        double maxScrollExtent = scrollControllerRev.position.maxScrollExtent;

        if (isScrollingForwardSecond) {
          if (currentScrollPosition >= maxScrollExtent) {
            // Reverse direction
            isScrollingForwardSecond = false;
          } else {
            scrollControllerRev.animateTo(
              currentScrollPosition + scrollAmount,
              duration: scrollDuration,
              curve: Curves.easeInOutCirc,
            );
          }
        } else {
          if (currentScrollPosition <= 0) {
            // Reverse direction
            isScrollingForwardSecond = true;
          } else {
            scrollControllerRev.animateTo(
              currentScrollPosition - scrollAmount,
              duration: scrollDuration,
              curve: Curves.easeInOutCirc,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: appBar(),
      ),
    );
  }

  Widget appBar() {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        // Use SliverAppBar for appBarUI
        SliverAppBar(
          expandedHeight: 140.0,
          floating: false,
          // pinned: true,
          backgroundColor: Colors.transparent,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: const EdgeInsets.only(bottom: 4),
            title: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Logo on the left side of the AppBar
                        ClipOval(
                          child: Image.asset(
                            'assets/anuj/homepage/rlogo.png', // Your logo asset
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // AppBar title in the center
                        const Expanded(
                          child: Text(
                            "Retrivo",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center, // Centered title
                          ),
                        ),
                        // User Profile Icon with Dropdown Menu
                        /*PopupMenuButton(
                          icon: const Icon(Icons.account_circle,
                              color: Colors.white),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Text("Profile"),
                            ),
                            const PopupMenuItem(
                              value: 2,
                              child: Text("Settings"),
                            ),
                            const PopupMenuItem(
                              value: 3,
                              child: Text("Logout"),
                            ),
                          ],
                          onSelected: (value) {
                            // Handle menu selection
                            switch (value) {
                              case 1:
                                // Navigate to Profile Screen
                                break;
                              case 2:
                                // Navigate to Settings Screen
                                break;
                              case 3:
                                // Handle logout
                                break;
                            }
                          },
                        ),*/
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Profile_Page();
                              // return const UserProfile();
                            }));
                          },
                          child: ClipOval(
                            child: Image.asset(
                              "assets/Shivam/images/humanImage.png", // Profile image
                              width: 38,
                              height: 38,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Animated Search bar
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: ItemSearchDelegate(),
                            );
                          },
                          child: Container(
                            height: 35,
                            width: 215,
                            margin: const EdgeInsets.only(
                                left: 8, right: 0, bottom: 8),
                            padding: const EdgeInsets.only(left: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                //const SizedBox(width: 10),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Search...",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ),
                                ),
                                // Add clear icon for search bar
                                /*IconButton(
                                  icon:
                                      const Icon(Icons.clear, color: Colors.grey),
                                  onPressed: () {
                                    // Logic to clear search input if necessary
                                  },
                                ),*/
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const NotificationsScreen();
                            }));
                          },
                          icon: const Icon(Icons.notifications,
                              color: Colors.white, size: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Gradient Background
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Blur effect
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 4,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              BackgroundDecoration(
                child: Column(children: [
                  Container(
                      height: 300,
                      margin: const EdgeInsets.only(top: 18),
                      child: carousel()),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        // color: Colors.yellow,
                      ),
                      height: 600,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            // Padding widget to add padding around the container
                            padding: const EdgeInsets.all(
                                10.0), // Adjust the padding value as needed
                            child: Card(
                              elevation:
                                  10, // Increased elevation for more depth
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, right: 10, left: 5),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffa3bded), // Light blue
                                      Color(
                                          0xff6991c7), // Darker shade for gradient
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize:
                                            28, // Larger font size for better readability
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.4,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 6,
                                            offset: const Offset(2, 4),
                                          ),
                                        ],
                                      ),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          TyperAnimatedText(
                                            "What are you looking for?",
                                            speed: const Duration(
                                                milliseconds:
                                                    80), // Faster typing
                                          ),
                                        ],
                                        isRepeatingAnimation: true,
                                        totalRepeatCount: 6,
                                        pause: const Duration(seconds: 2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(child: category1()),
                          const SizedBox(
                            height: 2,
                          ),
                          Expanded(child: category2()),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  lostCarousel(lostpage.imagesUrls),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to BottomNavigation with initialIndex = 1 for Report Lost
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavigation(initialIndex: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                          side: const BorderSide(
                              color: Colors.redAccent), // Border color
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30), // Padding
                        elevation: 5, // Shadow
                      ),
                      child: const Text(
                        'Report Lost Item',
                        style: TextStyle(
                          fontSize: 18, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  foundCarousel(foundpage.imagesUrls),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to BottomNavigation with initialIndex = 2 for Report Found
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavigation(initialIndex: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                          side: const BorderSide(
                              color: Colors.lightGreen), // Border color
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30), // Padding
                        elevation: 5, // Shadow
                      ),
                      child: const Text(
                        'Report Found Item',
                        style: TextStyle(
                          fontSize: 18, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget carousel() {
    final List<Map<String, String>> carouselData = [
      {
        'image': lostCards[0].url,
        'title': "Lost ${lostCards[0].name}",
        'description': "Found ${lostCards[0].description}",
      },
      {
        'image': lostCards[1].url,
        'title': "Lost ${lostCards[1].name}",
        'description': "Found ${lostCards[1].description}",
      },
      {
        'image': lostCards[2].url,
        'title': "Lost ${lostCards[2].name}",
        'description': "Found ${lostCards[2].description}",
      },
      {
        'image': foundCards[0].url.toString(),
        'title': "Found ${foundCards[0].name}",
        'description': "Found ${foundCards[0].description}",
      },
      {
        'image': foundCards[1].url.toString(),
        'title': "Found ${foundCards[1].name}",
        'description': "Found ${foundCards[1].description}",
      },
      {
        'image': foundCards[2].url.toString(),
        'title': "Found ${foundCards[2].name}",
        'description': "Found ${foundCards[2].description}",
      },
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 265,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 265,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    pageNo = index;
                  });
                },
                itemBuilder: (context, int index) {
                  return AnimatedBuilder(
                    animation: pageController!,
                    builder: (context, child) {
                      return child!;
                    },
                    child: GestureDetector(
                      onTap: () {
                        // Handle tap action for more details if needed
                      },
                      onPanDown: (d) {
                        carasouelTimer?.cancel();
                        carasouelTimer = null;
                      },
                      onPanCancel: () {
                        carasouelTimer = getTimer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            image: DecorationImage(
                              image:
                                  NetworkImage(carouselData[index]['image']!),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Semi-transparent overlay
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black
                                      .withOpacity(0.5), // Dark overlay
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              // Text content over the image
                              Positioned(
                                bottom: 20,
                                left: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      carouselData[index]['title']!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            offset: const Offset(1, 1),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      carouselData[index]['description']!,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            offset: const Offset(1, 1),
                                            blurRadius: 5,
                                          ),
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
                    ),
                  );
                },
                itemCount: carouselData.length,
              ),
            ),
            const SizedBox(height: 10),
            // Page Indicators for Carousel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                carouselData.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    Icons.circle,
                    size: 12,
                    color: pageNo == index
                        ? Colors.indigoAccent
                        : Colors.grey.shade300,
                  ),
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget category1() {
    return GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        // shrinkWrap: true,
        itemCount: categories1.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 350,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            //open the list page for that category
            onTap: () {
              log(pageCategories1[index]);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MyCategoryList(category: pageCategories1[index]);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        fieldCategory1[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    // Gradient Overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    // Label Text (optional)
                    Positioned(
                      bottom: 82,
                      left: 50,
                      child: Text(
                        maxLines: 2,
                        categories1[index], // Replace with actual item name
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget category2() {
    return GridView.builder(
        controller: scrollControllerRev,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: categories1.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 350,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              log(pageCategories2[index]);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MyCategoryList(category: pageCategories2[index]);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        fieldCategory2[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    // Gradient Overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    // Label Text (optional)
                    Positioned(
                      bottom: 89,
                      left: 50,
                      child: Text(
                        maxLines: 2,
                        categories2[index], // Replace with actual item name
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                // ,
              ),
            ),
          );
        });
  }
}

Widget foundCarousel(List<String> images) {
  // List of found names corresponding to the images
  List<String> foundname = [
    lostCards[lostCards.length - 1].name,
    lostCards[lostCards.length - 2].name,
    lostCards[lostCards.length - 3].name,
    lostCards[lostCards.length - 4].name,
  ];

  return Column(
    children: [
      const SizedBox(
        height: 5,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffa3bded), // Light blue
                  Color(0xff6991c7), // Darker shade for gradient
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText("Is it Yours?"),
                          ],
                          isRepeatingAnimation: true,
                          totalRepeatCount: 6,
                          pause: const Duration(seconds: 3),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText("Claim Now!"),
                            ],
                            isRepeatingAnimation: true,
                            totalRepeatCount: 6,
                            pause: const Duration(seconds: 3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      CarouselSlider.builder(
        itemCount: images.length,
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 3),
          viewportFraction: 0.8,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 214, 214, 214).withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // Gradient Overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                // Label Text
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    foundname[
                        index], // Use the corresponding name for the image
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}

Widget lostCarousel(List<String> images) {
  // List of lost item names corresponding to the images
  List<String> foundname = [
    foundCards[foundCards.length - 1].name,
    foundCards[foundCards.length - 2].name,
    foundCards[foundCards.length - 3].name,
    foundCards[foundCards.length - 4].name,
  ];

  return Column(
    children: [
      const SizedBox(height: 5),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffa3bded), // Light blue
                  Color(0xff6991c7), // Darker shade for gradient
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText("Have you found it?"),
                          ],
                          isRepeatingAnimation: true,
                          totalRepeatCount: 6,
                          pause: const Duration(seconds: 3),
                        ),
                      ),
                      const SizedBox(height: 5),
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText("Report Us!"),
                          ],
                          isRepeatingAnimation: true,
                          totalRepeatCount: 6,
                          pause: const Duration(seconds: 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      CarouselSlider.builder(
        itemCount: images.length,
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 3),
          viewportFraction: 0.8,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // Gradient Overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                // Label Text
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    foundname[
                        index], // Display the corresponding name for the image
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
