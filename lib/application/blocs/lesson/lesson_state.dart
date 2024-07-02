part of 'lesson_bloc.dart';

class LessonState extends Equatable {
  final Lesson lesson;
  final List<Lesson> courseLessons;
  final bool firstLesson;
  final bool lastLesson;
  final String courseImage;

  const LessonState({
    this.courseLessons = const [],
    this.lesson = const Lesson(
        id: '',
        title: '',
        comments: [],
        content: '',
        imageUrl: '',
        videoUrl: ''),
    this.firstLesson = false,
    this.lastLesson = false,
    this.courseImage = '',
  });

  LessonState copyWith(
          {Lesson? lesson,
          List<Lesson>? courseLessons,
          bool? firstLesson,
          bool? lastLesson,
          String? courseImage}) =>
      LessonState(
        courseLessons: courseLessons ?? this.courseLessons,
        firstLesson: firstLesson ?? this.firstLesson,
        lastLesson: lastLesson ?? this.lastLesson,
        lesson: lesson ?? this.lesson,
        courseImage: courseImage ?? this.courseImage,
      );

  @override
  List<Object> get props =>
      [lesson, courseLessons, firstLesson, lastLesson, courseImage];
}

class LessonLoading extends LessonState {
  const LessonLoading(
      {super.courseLessons = const [],
      super.lesson = const Lesson(
          id: '',
          title: '',
          comments: [],
          content: '',
          imageUrl: '',
          videoUrl: ''),
      super.firstLesson = false,
      super.lastLesson = false,
      super.courseImage = ''});
}

class LessonChanging extends LessonState {
  const LessonChanging({
    required super.courseLessons,
    required super.firstLesson,
    required super.lastLesson,
    required super.lesson,
    required super.courseImage,
  });
}

class LessonLoaded extends LessonState {
  const LessonLoaded({
    required super.courseLessons,
    required super.firstLesson,
    required super.lastLesson,
    required super.lesson,
    required super.courseImage,
  });
}

class LessonError extends LessonState {
  final String message;

  const LessonError({required this.message});
}
