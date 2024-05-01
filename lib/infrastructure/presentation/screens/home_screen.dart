import 'package:flutter/material.dart';
import 'package:flutter_template/presentation/widgets/ui/brand_gradient.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 230),
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                    image: DecorationImage(
                        image: AssetImage('assets/particles.png'),
                        alignment: Alignment.topRight,
                        fit: BoxFit.cover),
                    gradient: brandGradient),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, left: 10, right: 10, bottom: 20),
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
                                backgroundImage:
                                    AssetImage('assets/test_user.jpeg'),
                                radius: 20,
                              ))
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 44,
                          decoration: const BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
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
                                  Icons.search_rounded,
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
                            Icon(Icons.calendar_month)
                          ],
                        ),
                      )
                    ],
                  ),
                ))),
        body: const Placeholder());
  }
}
