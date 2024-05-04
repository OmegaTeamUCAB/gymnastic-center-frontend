import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 209, 208, 208),
      child: const Center(
          child: Text('Settings page')
        ),
    );
  }
}