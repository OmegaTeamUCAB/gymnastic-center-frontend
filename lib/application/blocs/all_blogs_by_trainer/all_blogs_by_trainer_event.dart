part of 'all_blogs_by_trainer_bloc.dart';

sealed class AllBlogsByTrainerEvent {
  const AllBlogsByTrainerEvent();
}

class AllBlogsByTrainerRequested extends AllBlogsByTrainerEvent {
  final String trainerId;
  final int page;
  const AllBlogsByTrainerRequested(this.trainerId, this.page);
}
