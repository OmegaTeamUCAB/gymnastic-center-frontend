import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/training/trainig_app_bar.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 150), child: TrainigAppBar()),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 1, 30, 15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Most Popular Courses',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: Text(
                    'See All>',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 130, // Ajusta la altura según tus necesidades
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return buildSizedBoxRow();
                },
              ),
            ),
            // const SizedBox(
            //   height: 15,
            // ),
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
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                buildSizedBoxColumn()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildSizedBoxRow() {
  return Column(
    children: [
      SizedBox(
        child: Stack(
          children: <Widget>[
            Image.asset('assets/img_most_popular_courses.png'),
            const Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Savannah Nguyen',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Yoga app',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 150,
      ),
    ],
  );
}

Widget buildSizedBoxColumn() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.fromLTRB(10, 3, 5, 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '30 day yoga challenge',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ralph Edwards',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    'Level 5',
                    style: TextStyle(fontSize: 10, color: Colors.purple),
                  ),
                ],
              ),
            ),
            Image.asset('assets/trainig_programs_master.png',
                width: 150, height: 150),
          ],
        ),
      ),
      const SizedBox(height: 15),
    ],
  );
}
