import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/disability/disability_app_bar.dart';

class DisabilityScreen extends StatelessWidget {
  const DisabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 150), child: DisabilityAppBar()),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0.8, 30, 15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Most Popular Courses',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                buildSizedBoxRow(),
                buildSizedBoxRow(),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Programs Master',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                buildSizedBoxColumn(),
                buildSizedBoxColumn(),
                buildSizedBoxColumn(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildSizedBoxRow() {
  // ignore: prefer_const_constructors
  return Column(
    children: [
      Positioned(
        child: Center(
          child: Image.asset(
            'assets/disability_mostpopularcourses.png',
            width: 150,
          ),
        ),
      ),
      const SizedBox(
        width: 160,
      ),
    ],
  );
}

Widget buildSizedBoxColumn() {
  return Column(
    children: [
      const SizedBox(
        height: 15,
      ),
      Positioned(
        child: Center(
          child: Image.asset(
            'assets/disability_programsmaster.png',
            width: 2000,
          ),
        ),
      ),
    ],
  );
}
