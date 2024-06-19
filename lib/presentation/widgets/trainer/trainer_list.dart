import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/presentation/screens/trainer_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';

class TrainerList extends StatelessWidget {
  final List<Trainer> trainers;
  const TrainerList({super.key, required this.trainers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: trainers.map((trainer) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TrainerScreen(trainerId: trainer.id!)),
              );
            },
            title: Text(
              trainer.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary),
            subtitle: Text(
                '${trainer.followers} ${trainer.followers == 1 ? 'follower' : 'followers'} | ${trainer.location}'),
            leading: trainer.image != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(trainer.image!),
                  )
                : const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.person,
                      size: 30,
                    ),
                  ),
            trailing: BrandButton(
              onPressed: () {
                // follow trainer
              },
              isVariant: trainer.userFollow!,
              fontSize: 15,
              width: 90,
              text: trainer.userFollow! ? 'following' : 'follow',
            ),
          ),
        );
      }).toList(),
    );
  }
}
