// User Profile Screflutter_slidableen

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_report.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // function to create custom textstyle
  TextStyle customTextStyle(double fontSize, Color color,
      {FontWeight fontWeight = FontWeight.normal}) {
    return GoogleFonts.quicksand(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  // list of information
  List<Map<String, String>> info = [
    {"title": "Contact", "content": "9020XXXXXX"},
    {"title": "Email", "content": "gauridagale@gmail.com"},
    {"title": "Address", "content": "Narhe, Pune"},
    {"title": "Profession", "content": "Student"},
    {"title": "My Reports", "content": "view your reports"},
  ];

  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = info
        .map((item) => TextEditingController(text: item["content"]))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Dialog box for editing content
  void showEditDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController editController =
            TextEditingController(text: info[index]["content"]);
        return AlertDialog(
          title: Text("Edit ${info[index]["title"]}",
              style: customTextStyle(22, Colors.blue,
                  fontWeight: FontWeight.w600)),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              labelText: 'Content',
              labelStyle: customTextStyle(17, const Color.fromARGB(255, 51, 60, 232),
                  fontWeight: FontWeight.w600),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 51, 60, 232), width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),

            // save button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  info[index]["content"] = editController.text;
                  _controllers[index].text = editController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget buildInfoContainer(String title, String content, int index) {
    bool isMyReports = title == "My Reports";

    return Column(
      children: [
        GestureDetector(
          // if Title is My Reports navigate to next screen
          onTap: isMyReports
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyReport()),
                  );
                }
              : null,
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: const Color.fromARGB(255, 215, 231, 244),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    title,
                    style: customTextStyle(25, Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // slidable for sliding container
                Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.transparent,
                        icon: Icons.delete_outline,
                        foregroundColor: Colors.black,
                        label: 'Delete',
                        onPressed: (context) {
                          setState(() {
                            info.removeAt(index);
                            _controllers.removeAt(index);
                          });
                        },
                      ),
                      SlidableAction(
                        backgroundColor: Colors.transparent,
                        icon: Icons.edit_outlined,
                        foregroundColor: Colors.black,
                        label: 'Edit',
                        onPressed: (context) {
                          showEditDialog(index);
                        },
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      content,
                      style: customTextStyle(20, Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // function for snackbar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            color: const Color.fromARGB(255, 129, 163, 226),
          ),
          title: Text(
            "User Profile",
            style:
                customTextStyle(28, Colors.white, fontWeight: FontWeight.w600),
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
        children: [
          const Padding(padding: EdgeInsets.all(20)),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3.5),
                shape: BoxShape.circle,
                color: Colors.transparent),
            child: const Icon(
              Icons.person_outlined,
              size: 140,
              color: Colors.black,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              const SizedBox(
                width: 125,
              ),
              Text("Gauri Dagale",
                  style: customTextStyle(25, Colors.black,
                      fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 80,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.edit_outlined,size: 20, color: Colors.black,))
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: info.asMap().entries.map((entry) {
                  int index = entry.key;
                  String title = entry.value['title']!;
                  String content = entry.value['content']!;
                  return buildInfoContainer(title, content, index);
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                _showSnackbar(context, "Your details are saved..!!");
              },
              style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 215, 231, 244)),
              ),
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
