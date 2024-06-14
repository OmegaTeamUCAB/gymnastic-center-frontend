import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/trainer_detail/trainer_detail_bloc.dart';
import 'package:gymnastic_center/presentation/screens/loading_screen.dart';
import 'package:gymnastic_center/presentation/widgets/trainer/trainer_info.dart';

class TrainerScreen extends StatefulWidget {
  final Map trainer;
  const TrainerScreen({super.key, required this.trainer});

  @override
  State<TrainerScreen> createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = false;
  late final trainerDetailBloc = GetIt.instance<TrainerDetailBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    trainerDetailBloc
        .add(TrainerDetailRequested(trainerId: widget.trainer['id']));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 100) {
      setState(() {
        _showFab = true;
      });
    } else {
      setState(() {
        _showFab = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<TrainerDetailBloc>.value(
            value: trainerDetailBloc,
            child: BlocBuilder<TrainerDetailBloc, TrainerDetailState>(
                builder: (context, state) {
              if (state is TrainerDetailLoading) {
                return const LoadingScreen();
              }
              if (state is TrainerDetailLoaded) {
                return TrainerInfo(
                  trainer: state.trainer,
                  scrollController: _scrollController,
                  showFab: _showFab,
                );
              } else {
                return const Center(
                  child: Text('Error loading trainer'),
                );
              }
            })));
  }
}
