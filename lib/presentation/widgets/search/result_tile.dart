import 'package:flutter/material.dart';

class ResultTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  const ResultTile(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: const Color.fromARGB(255, 195, 195, 195),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          description,
        ),
        subtitleTextStyle: const TextStyle(
            fontSize: 12, overflow: TextOverflow.ellipsis, color: Colors.black),
        onTap: onTap,
      ),
    );
  }
}
