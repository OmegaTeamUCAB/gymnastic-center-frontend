import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/bloc/follow_trainer_bloc.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/presentation/screens/trainer_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';

class TrainerList extends StatefulWidget {
  final List<Trainer> trainers;
  const TrainerList({super.key, required this.trainers});

  @override
  State<TrainerList> createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  late FollowTrainerBloc followTrainerBloc;
  late List<bool> followStatus;
  late List<dynamic> followers;

  @override
  void initState() {
    followTrainerBloc = GetIt.instance<FollowTrainerBloc>();
    followStatus =
        widget.trainers.map((trainer) => trainer.userFollow!).toList();
    followers =
        widget.trainers.map((trainer) => trainer.followers ?? 0).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.trainers.asMap().entries.map((entry) {
        int index = entry.key;
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
              subtitle:
                  Text('${followers[index]} followers | ${trainer.location}'),
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
              trailing: BlocBuilder<FollowTrainerBloc, FollowTrainerState>(
                builder: (context, state) {
                  if (state is FollowTrainerFailed) {
                    setState(() {
                          followStatus[index] = !followStatus[index];
                          if (followStatus[index]) {
                            followers[index]++;
                          } else {
                            followers[index]--;
                          }
                        });
                  }
                  return BrandButton(
                    onPressed: () {
                      setState(() {
                        followStatus[index] = !followStatus[index];
                        if (followStatus[index]) {
                          followers[index]++;
                        } else {
                          followers[index]--;
                        }
                      });

                      followTrainerBloc.add(FollowRequested(id: trainer.id!));
                    },
                    isVariant: followStatus[index],
                    fontSize: 14,
                    width: 90,
                    text: followStatus[index] ? 'following' : 'follow',
                  );
                },
              ),
            ));
      }).toList(),
    );
  }

  StreamBuilder<FollowTrainerState> _buildFollowSnackbar(
      Stream<FollowTrainerState> stream) {
    return StreamBuilder<FollowTrainerState>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is FollowTrainerSuccess) {
            return SnackBar(
              content: Text("You're now following !"),
              backgroundColor: Colors.green,
            );
          } else if (snapshot.data is FollowTrainerFailed) {
            return SnackBar(
              content: Text("Failed to follow. Please try again."),
              backgroundColor: Colors.red,
            );
          }
        }
        return const SnackBar(
            content: Text(
                'Processing')); // Show loading Snackbar while awaiting event
      },
    );
  }
}
