part of 'lesson_bloc.dart';

class LessonState extends Equatable {
  final Lesson lesson;
  final List<Lesson> courseLessons;
  final bool firstLesson;
  final bool lastLesson;
  
  const LessonState({
    this.courseLessons = const [],
    this.lesson = const Lesson(id: '', title: '', comments: [], content: '', imageUrl: '', videoUrl: ''),
    this.firstLesson = false,
    this.lastLesson = false,
  });

  LessonState copyWith({
  Lesson? lesson,
  List<Lesson>? courseLessons,
  bool? firstLesson,
  bool? lastLesson,
  }) => LessonState(
    courseLessons: courseLessons ?? this.courseLessons, 
    firstLesson: firstLesson ?? this.firstLesson, 
    lastLesson: lastLesson ?? this.lastLesson,
    lesson: lesson ?? this.lesson,  
  );

  @override
  List<Object> get props => [lesson, courseLessons, firstLesson, lastLesson];
}

class LessonLoading extends LessonState {
  LessonLoading({
    super.courseLessons = const [],
    super.lesson = const Lesson(id: '', title: '', comments: [], content: '', imageUrl: '', videoUrl: ''),
    super.firstLesson = false,
    super.lastLesson = false,
  });
}

class LessonChanging extends LessonState {

  LessonChanging({
    required super.courseLessons,
    required super.firstLesson,
    required super.lastLesson,
    required super.lesson,
  });

}

class LessonLoaded extends LessonState {

  LessonLoaded({
    required super.courseLessons,
    required super.firstLesson,
    required super.lastLesson,
    required super.lesson,
  });

}

class LessonError extends LessonState {
  final String message;

  LessonError({required this.message});

}
