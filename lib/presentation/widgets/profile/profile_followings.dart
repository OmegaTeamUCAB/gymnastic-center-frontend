import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/trainer_user_follow/trainer_user_follow_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileFollowings extends StatefulWidget {
  const ProfileFollowings({super.key});

  @override
  State<ProfileFollowings> createState() => _ProfileFollowingsState();
}

class _ProfileFollowingsState extends State<ProfileFollowings> {
  late TrainerUserFollowBloc _trainerUserFollowBloc;
  bool showTimeoutIndicator = false;

  @override
  void initState() {
    super.initState();
    _trainerUserFollowBloc = GetIt.instance<TrainerUserFollowBloc>();
    _trainerUserFollowBloc.add(const TrainerUserFollowRequested(count: 0));
    Timer(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {
          showTimeoutIndicator = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _trainerUserFollowBloc,
      child: BlocBuilder<TrainerUserFollowBloc, TrainerUserFollowState>(
        builder: (context, state) {
          if (state is TrainerUserFollowLoading) {
            if (showTimeoutIndicator) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("-",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.normal)),
                    Text(
                      AppLocalizations.of(context)!.following,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(),
                child: SizedBox(
                  height: 10.0,
                  width: 10.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              ),
            );
          } else if (state is TrainerUserFollowFailed) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is TrainerUserFollowSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.count.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context)!.following,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                )
              ],
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
