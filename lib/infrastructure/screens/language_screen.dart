import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class LanguageScreen extends StatelessWidget {
  static const name = 'language_screen';

  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          color: Colors
                              .white), // Ícono de flecha hacia la izquierda
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Language',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )),
    );
  }
}
