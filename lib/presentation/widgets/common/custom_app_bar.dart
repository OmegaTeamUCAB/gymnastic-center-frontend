import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class CustomAppBar extends StatelessWidget {
  final Widget content;
  const CustomAppBar({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
            image: DecorationImage(
                image: AssetImage('assets/particles.png'),
                alignment: Alignment.topRight,
                fit: BoxFit.cover),
            gradient: brandGradient),
        child: Padding(
            padding:
                const EdgeInsets.only(top: 60, left: 8, right: 8, bottom: 20),
            child: content));
  }
}
