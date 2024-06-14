part of 'all_blogs_by_trainer_bloc.dart';

sealed class AllBlogsByTrainerEvent {
  const AllBlogsByTrainerEvent();
}

class AllBlogsRequestedByTrainer extends AllBlogsByTrainerEvent {
  final int trainerId;
  final int page;
  const AllBlogsRequestedByTrainer(this.trainerId, this.page);
}
