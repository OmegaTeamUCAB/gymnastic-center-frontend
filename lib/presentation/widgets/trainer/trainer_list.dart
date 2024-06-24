import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/follow_trainer/follow_trainer_bloc.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/presentation/screens/trainer_screen.dart';

class TrainerList extends StatefulWidget {
  final List<Trainer> trainers;
  const TrainerList({super.key, required this.trainers});

  @override
  State<TrainerList> createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  late FollowTrainerBloc followTrainerBloc;

  @override
  void initState() {
    super.initState();
    followTrainerBloc = GetIt.instance<FollowTrainerBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: followTrainerBloc,
      child: Column(
        children: widget.trainers.asMap().entries.map((entry) {
          Trainer trainer = entry.value;
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
                    builder: (context) => TrainerScreen(trainerId: trainer.id!),
                  ),
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
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              trailing: trainer.userFollow!
                  ? const Text('Following')
                  : Text(
                      '${trainer.followers} ${trainer.followers == 1 ? 'follower' : 'followers'}'),
              subtitle: Text(trainer.location!),
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
            ),
          );
        }).toList(),
      ),
    );
  }
}
