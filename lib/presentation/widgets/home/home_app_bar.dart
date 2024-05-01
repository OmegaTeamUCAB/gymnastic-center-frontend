import 'package:flutter/material.dart';
import 'package:flutter_template/infrastructure/presentation/screens/search_screen.dart';
import 'package:flutter_template/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:flutter_template/presentation/widgets/ui/custom_app_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                const Column(
                  children: [
                    Text(
                      'Jhon Doe',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ID: Raxsdfe34879',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                      backgroundImage: AssetImage('assets/test_user.jpeg'),
                      radius: 25,
                    ))
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: Container(
                height: 44,
                decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Search',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF677294)),
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
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(right: 40, left: 15),
              child: Row(
                children: [
                  Text(
                    'Tomorrow',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Today',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Yesterday',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Spacer(),
                  Icon(
                    GymnasticCenter.calendar,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
