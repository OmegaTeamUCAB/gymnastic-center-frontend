import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/search_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() openDrawer;
  const MainAppBar({super.key, required this.openDrawer});

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
      leading: IconButton(
        onPressed: openDrawer,
        icon: const Icon(
          Icons.menu_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
          icon: const Icon(
            GymnasticCenter.search,
            size: 25,
            color: Colors.white,
          ),
        )
      ],
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Image.asset(
          'assets/app-launcher/app_icon.png',
          width: 45,
          fit: BoxFit.contain,
        ),
      ),
      // title: const Text('Gymnastic Center',
      //     style: TextStyle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white)),
    );
  }
}
