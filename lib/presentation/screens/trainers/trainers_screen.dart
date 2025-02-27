import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_trainers/all_trainers_bloc.dart';
import 'package:gymnastic_center/presentation/screens/trainers/loading_trainers_list.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/common/main_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/trainer/trainer_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainersScreen extends StatefulWidget {
  const TrainersScreen({super.key});

  @override
  State<TrainersScreen> createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  late AllTrainersBloc allTrainersBloc;
  late final PaginationController paginationController;

  @override
  void initState() {
    super.initState();
    allTrainersBloc = GetIt.instance<AllTrainersBloc>();
    allTrainersBloc.add(const AllTrainersRequested(page: 1));
    paginationController = PaginationController(
      requestNextPage: (page) =>
          allTrainersBloc.add(AllTrainersRequested(page: page)),
    );
  }

  @override
  void dispose() {
    paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: MainAppBar(openDrawer: () => Scaffold.of(context).openDrawer()),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.trainers,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 15),
              BlocProvider<AllTrainersBloc>.value(
                value: allTrainersBloc,
                child: BlocBuilder<AllTrainersBloc, AllTrainersState>(
                    builder: (context, state) {
                  if (state is AllTrainersLoading) {
                    return const Center(
                      child: LoadingTrainersList(),
                    );
                  }
                  if (state is AllTrainersFailed) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is AllTrainersSuccess) {
                    if (state.trainers.isEmpty) {
                      return const Center(
                        child: NoResults(),
                      );
                    }
                    return TrainerList(
                      trainers: state.trainers,
                    );
                  } else {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                }),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
