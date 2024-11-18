// ignore_for_file: file_names

// import 'package:flutter/material.dart';

// class LostItemsPage extends StatelessWidget {
//   const LostItemsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Lost Items Page',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

class LostModel {
  final String id;
  final String name;
  final String? category;
  final String date;
  final String location;
  final String description;
  final String number;
  String? url;
  String? reward;

  LostModel({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.location,
    required this.description,
    required this.number,
    this.url,
    this.reward,
  });
}
