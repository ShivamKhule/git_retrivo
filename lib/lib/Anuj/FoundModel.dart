// ignore_for_file: file_names

// import 'package:flutter/material.dart';

// class FoundItemsPage extends StatelessWidget {
//   const FoundItemsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Found Items Page',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }



class FoundModel {
  final String id;
  final String name;
  final String? category;
  final String date;
  final String location;
  final String description;
  final String number;
  // String ownerName;
  // String email;
  String? mapLocation;
  String? url;
  String? billurl;
  String? reward;

  FoundModel({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.location,
    required this.description,
    required this.number,
    // required this.email,
    // required this.ownerName,
    this.mapLocation,
    this.url,
    this.billurl,
    // String? reward,
  });
}