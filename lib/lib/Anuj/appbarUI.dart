// ignore_for_file: file_names

import 'dart:ui';
import 'package:flutter/material.dart';

Widget appBarUI(BuildContext context) {
    return  SliverAppBar(
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: const EdgeInsets.only(bottom: 25),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo on the left side of the AppBar
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/retrivo.png', // Your logo asset
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
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
                  PopupMenuButton(
                    icon: const Icon(Icons.account_circle, color: Colors.white),
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
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              // Animated Search bar
              GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: ItemSearchDelegate(),
                  );
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const  [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Search...",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      // Add clear icon for search bar
                      IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          // Logic to clear search input if necessary
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
      );
} // End of appBar()

// Custom Search Delegate to handle search logic
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
            query = suggestions[index]; // Set the selected suggestion as the query
            showResults(context); // Show the results
          },
        );
      },
    );
  }
} // End of ItemSearchDelegateof ItemSearchDelegate
