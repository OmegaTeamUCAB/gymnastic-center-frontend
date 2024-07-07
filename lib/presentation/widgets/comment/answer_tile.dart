import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/screens/trainer_screen.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';

class AnswerTile extends StatelessWidget {
  final Answer answer;
  const AnswerTile({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceTint.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.subdirectory_arrow_right_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 5),
                ProfileAvatar(
                  fullName: answer.trainerName,
                  urlImage: answer.trainerImage,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrainerScreen(
                                trainerId: answer.trainerId,
                              )),
                    );
                  },
                  radius: 20,
                ),
                const SizedBox(width: 10),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${answer.trainerName} \u2022 ${formatDateTime(answer.date)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    answer.body,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
