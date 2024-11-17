import 'package:flutter/material.dart';
import 'package:git_retrivo/lib/Gauri/my_report.dart';
// import 'package:Gauri/my_report.dart';
// import 'package:git_retrivo/lib/Shivam/lib/lib/Gauri/my_report.dart';

import '../Gauri/login_page.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});
  @override
  State createState() => _Profile_PageState();
}

class _Profile_PageState extends State {
  // Method to show confirmation dialog
  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
          title: const Row(
            children: [
              Icon(Icons.logout, color: Colors.redAccent), // Icon for Logout
              SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey[700],
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Call the logout method
              },
            ),
          ],
        );
      },
    );
  }

  // Method to handle logout
  void _logout() {
    print("User logged out.");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }),
      (route) {
        return false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.blue.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, // Action for back button
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      size: 30,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Edit Profile", // Menu item to edit profile
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.settings_suggest_outlined,
                      size: 30,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Settings", // Menu item for settings
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      size: 30,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Logout", // Menu item for logout
                      style: TextStyle(fontSize: 17, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              print("Edit Profile is selected.");
              /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return null;
              }));*/
            } else if (value == 1) {
              print("Settings menu is selected.");
            } else if (value == 2) {
              _showLogoutConfirmation();
              setState(() {});
            }
          }),
        ],
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.30,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.black54,
                  width: 5,
                )),
                color: Colors.grey,
              ),
              width: MediaQuery.of(context).size.width,
              height: 320,
              child: Image.asset(
                "assets/Shivam/images/humanImage.png", // Background image with opacity
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 247,
                ),
                Container(
                  width: 370,
                  height: 100,
                  margin: const EdgeInsets.all(22),
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 10, right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset:
                            const Offset(4, 4), // Shadow effect for container
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          "assets/Shivam/images/humanImage.png", // Profile image
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hello...!", // Welcome message
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "shivam2707", // Username
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {}, // Action for edit button
                        child: const Icon(
                          Icons.edit_note_outlined,
                          size: 30,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 370,
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 8, left: 4, right: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.2,
                        height: 12,
                      ),
                      const Text(
                        'Name :-',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.purple),
                      ),
                      const Text(
                        'Shivam Khule',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.2,
                        height: 12,
                      ),
                      const Text(
                        'Email ID :-',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.purple),
                      ),
                      const Text(
                        'shivamkhule@gmail.com',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.2,
                        height: 12,
                      ),
                      const Text(
                        'Bio :-',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.purple),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Show dialog with full bio text on tap
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'User Bio',
                                  style: TextStyle(fontWeight: FontWeight.bold,),
                                ),
                                content: const SingleChildScrollView(
                                  child: Text(
                                    "***Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.***",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          "***Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.***",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 4, // Limit the text to 4 lines
                          overflow: TextOverflow
                              .ellipsis, // Show "..." if text exceeds maxLines
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.2,
                        height: 12,
                      ),
                      const Text(
                        'Location :-',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.purple),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Maharashtra, Pune',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          GestureDetector(
                            child: const Row(
                              children: [
                                Text(
                                  'Visit',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.2,
                        height: 12,
                      ),
                      const Text(
                        'Contact :-',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.purple),
                      ),
                      const Text(
                        '+91 801055144',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.2,
                        height: 12,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const MyReport();
                        }));
                      },
                      child: Container(
                        width: 146,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.blueGrey, Colors.black87],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.my_library_books_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'My Reports', // Button for reports
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showLogoutConfirmation();
                        setState(() {});
                      },
                      child: Container(
                        width: 146,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red.shade300, Colors.red.shade800],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Logout', // Button for logout
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
