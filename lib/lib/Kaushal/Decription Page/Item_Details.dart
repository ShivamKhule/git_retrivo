import 'package:flutter/material.dart';


class ItemDetails extends StatelessWidget {

  List temp = [];
  int index;
  ItemDetails({super.key,required this.temp,required this.index});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(title: "Title", value: temp[index].name),
            const Divider(),
            DetailRow(
                title: "Category", value: temp[index].category.toString()),
            const Divider(),
            DetailRow(title: "Description", value: temp[index].description),
            const Divider(),
            DetailRow(
              title: "Lost Location", value: temp[index].location),
            const Divider(),
            DetailRow(title: "Lost Date", value: temp[index].date),
            if (temp[index].reward != null) ...[
              const Divider(),
              DetailRow(title: "Reward", value: temp[index].reward.toString()),
            ],
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
