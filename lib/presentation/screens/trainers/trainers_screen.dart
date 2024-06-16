import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/presentation/widgets/common/main_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/trainer/trainer_list.dart';

class TrainersScreen extends StatelessWidget {
  const TrainersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(openDrawer: () => Scaffold.of(context).openDrawer()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://st.depositphotos.com/62628780/56781/i/450/depositphotos_567815914-stock-photo-every-step-taken-towards-fitness.jpg',
              height: 210,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trainers',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const Text(
                    'Our trainers are the best in the business and are dedicated to helping you achieve your fitness goals.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  //TODO: use bloc logic
                  TrainerList(
                    trainers: [
                      Trainer(
                          name: 'Gianpiero Fusco',
                          followers: 35,
                          image:
                              'https://avatarfiles.alphacoders.com/224/thumb-1920-224188.jpg',
                          location: 'Venezuela',
                          userFollow: true),
                      Trainer(
                          name: 'Carlos Villanueva',
                          followers: 35,
                          location: 'Chile',
                          userFollow: false),
                      Trainer(
                          name: 'Jessie Jones',
                          followers: 35,
                          location: 'Argentina',
                          userFollow: false),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
