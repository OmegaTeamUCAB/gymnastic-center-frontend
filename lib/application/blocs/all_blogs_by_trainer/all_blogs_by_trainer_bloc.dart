import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';

part 'all_blogs_by_trainer_event.dart';
part 'all_blogs_by_trainer_state.dart';

class AllBlogsByTrainerBloc
    extends Bloc<AllBlogsByTrainerEvent, AllBlogsByTrainerState> {
  AllBlogsByTrainerBloc(super.initialState);
}
