import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/search_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
        content: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 25, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.menu,
                //       color: Colors.white,
                //     )),
                Image.asset(
                  'assets/app-launcher/app_icon.png',
                  width: 50,
                  fit: BoxFit.contain,
                ),

                const Spacer(),

                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       GymnasticCenter.search,
                //       size: 20,
                //       color: Colors.white,
                //     )),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()),
                    );
                  },
                  child: Container(
                    height: 35,
                    width: 240,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(
                                fontSize: 15, color: Color(0xFF677294)),
                          ),
                          Spacer(),
                          Icon(
                            GymnasticCenter.search,
                            size: 15,
                            color: Color(0xFF677294),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
