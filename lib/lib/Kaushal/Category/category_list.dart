import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Anuj/HomePage.dart';
import '../Decription Page/description.dart';
import '../Found Page/found_list.dart';
import '../Lost Page/lost_list.dart';

String? globalCategory;

class MyCategoryList extends StatelessWidget {
  final String? category;
  MyCategoryList({super.key, required this.category}) {
    // log(globalCategory);
    globalCategory = category;
  }

  @override
  Widget build(BuildContext context) {
    print(globalCategory);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoryList(showLost: true), // Show Lost items by default
    );
  }
}

class CategoryList extends StatefulWidget {
  final bool showLost; // Parameter to select initial category

  const CategoryList({super.key, required this.showLost});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  late bool isLostSelected;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  // ignore: non_constant_identifier_names
  String title_category = "Categories";
  String selectedCategory =
      globalCategory.toString(); // Default category filter

  // Initialize the animation and selected category based on the initial state
  @override
  void initState() {
    super.initState();
    isLostSelected = widget.showLost;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  // Dispose of the controller when it's no longer needed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Toggle between Lost and Found categories
  void toggleSection(bool isLost) {
    setState(() {
      isLostSelected = isLost;
      _slideAnimation = Tween<Offset>(
        begin: Offset(isLost ? -1 : 1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0);
    });
  }

  // Filter the list based on the selected category
  List _filterByCategory(List items, String category) {
    if (category == "All") {
      return items;
    } else {
      return items.where((item) => item.category == category).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    double sectionWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: Text(title_category),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const HomepageClass();
            }));
          },
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton("Lost", isLostSelected,
                    () => toggleSection(true), sectionWidth),
                const SizedBox(width: 10),
                _buildCategoryButton("Found", !isLostSelected,
                    () => toggleSection(false), sectionWidth),
              ],
            ),
          ),
          // Dropdown for selecting a category filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: DropdownButton<String>(
              value: selectedCategory,
              items: [
                "All",
                "Electronics",
                "Documents",
                "Personal Items",
                "Clothing And Accessories",
                "Transportation",
                "Pets",
                "Household Items",
                "Others"
              ]
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
          ),
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: isLostSelected
                  ? _buildGrid(_filterByCategory(lostCards, selectedCategory),
                      "Lost", Colors.red)
                  : _buildGrid(_filterByCategory(foundCards, selectedCategory),
                      "Found", Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  // Build category toggle buttons with animated effects
  Widget _buildCategoryButton(
      String label, bool isSelected, VoidCallback onTap, double width) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width / 2 - 5,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.quicksand(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Build grid view for filtered items based on the selected category
  Widget _buildGrid(List items, String type, Color labelColor) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return GridView.builder(
      key: ValueKey(type),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemCount: items.length,
      // log[itemCount],
      itemBuilder: (BuildContext context, int index) {
        print(index);
        return _buildItem(items[index], type, labelColor);
      },
    );
  }

  // Build item card for each lost or found item
  Widget _buildItem(dynamic item, String type, Color labelColor) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DescriptionPage();
        }));
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
                    child: Image.asset(
                      "assets/Kaushal/jpeg/ship.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.name,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16),
                      Flexible(
                        child: Text(
                          item.location,
                          style: GoogleFonts.quicksand(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.date,
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: labelColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                type,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
