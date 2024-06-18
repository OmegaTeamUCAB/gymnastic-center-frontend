import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/search_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
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

// Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/app-launcher/app_icon.png',
//                   width: 50,
//                   fit: BoxFit.contain,
//                 ),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SearchScreen()),
//                     );
//                   },
//                   child: Container(
//                     height: 35,
//                     width: 240,
//                     decoration: const BoxDecoration(
//                         color: Color(0xFFF2F2F2),
//                         borderRadius: BorderRadius.all(Radius.circular(6))),
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Search',
//                             style: TextStyle(
//                                 fontSize: 15, color: Color(0xFF677294)),
//                           ),
//                           Spacer(),
//                           Icon(
//                             GymnasticCenter.search,
//                             size: 15,
//                             color: Color(0xFF677294),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
