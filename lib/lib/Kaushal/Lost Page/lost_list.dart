import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Anuj/LostModel.dart';
import '../Decription Page/description.dart';
// import './Lost_Model.dart';

List<LostModel> lostCards = [];

class LostPage extends StatefulWidget {
  const LostPage({super.key});

  @override
  State<LostPage> createState() => _LostPageState();
}

class _LostPageState extends State<LostPage> {
  double screenWidth = 0;

  void filterSheet() {
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      filterSheet();
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
                            return DescriptionPage(index: index);
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
