part of 'all_course_by_trainer_bloc.dart';

sealed class AllCourseByTrainerEvent {
  const AllCourseByTrainerEvent();
}

class AllCourseByTrainerRequested extends AllCourseByTrainerEvent {
  final int page;
  final String trainerId;
  const AllCourseByTrainerRequested(this.trainerId, this.page);
}
