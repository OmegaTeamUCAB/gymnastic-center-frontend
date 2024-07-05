import 'package:flutter/material.dart';

class DeveloperAvatar extends StatelessWidget {
  final String name;
  final String role;
  final String image;
  const DeveloperAvatar(
      {super.key, required this.name, required this.role, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(image),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(role)
    ]);
  }
}
