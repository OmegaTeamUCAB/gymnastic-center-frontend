part of 'lesson_bloc.dart';

enum LessonStatus {loading, changing, loaded}

class LessonState extends Equatable {
  final LessonStatus lessonStatus;
  final Lesson lesson;
  final List<Lesson> courseLessons;
  final bool firstLesson;
  final bool lastLesson;
  final String courseImage;
  final String courseId;
  final Progress progress;
  
  const LessonState({
    this.lessonStatus = LessonStatus.loading,
    this.courseLessons = const [],
    this.lesson = const Lesson(id: '', title: '', comments: [], content: '', imageUrl: '', videoUrl: '', percent: null, time: null),
    
    this.firstLesson = false,
    this.lastLesson = false,
    this.courseImage = '',
    this.courseId = '',
    this.progress = const Progress(lessonProgress: [], percent: 0),
  });

  LessonState copyWith({
  LessonStatus? lessonStatus,
  Lesson? lesson,
  List<Lesson>? courseLessons,
  bool? firstLesson,
  bool? lastLesson,
  String? courseImage,
  String? courseId,
  Progress? progress
  }) => LessonState(
    lessonStatus: lessonStatus ?? this.lessonStatus,
    courseLessons: courseLessons ?? this.courseLessons, 
    firstLesson: firstLesson ?? this.firstLesson, 
    lastLesson: lastLesson ?? this.lastLesson,
    lesson: lesson ?? this.lesson,
    courseImage: courseImage ?? this.courseImage,
    courseId: courseId ?? this.courseId,
    progress: progress ?? this.progress,
  );

  @override
  List<Object> get props => [lesson, courseLessons, firstLesson, lastLesson, courseImage, courseId, lessonStatus, progress];
}

class LessonError extends LessonState {
  final String message;

  LessonError({required this.message});

}
