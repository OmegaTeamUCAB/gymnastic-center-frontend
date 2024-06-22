import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';

class BlogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BlogAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/particles.png'),
              alignment: Alignment.bottomLeft,
              fit: BoxFit.cover),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFF4F14A0), Color(0xFF8066FF)],
          ),
        ),
      ),
      leading: const BrandBackButton(),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Image.asset(
          'assets/app-launcher/app_icon.png',
          width: 45,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
