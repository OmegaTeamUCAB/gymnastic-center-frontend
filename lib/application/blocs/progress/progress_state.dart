part of 'progress_bloc.dart';

enum ProgressStatus { fetching, unitialized, loaded, saved, }

class ProgressState extends Equatable {
  final Progress progress;
  final ProgressStatus progressStatus;
  
  ProgressState({
    this.progress = const Progress(lessonProgress: [], percent: 0),
    this.progressStatus = ProgressStatus.fetching
  });

  ProgressState copyWith({
    Progress? progress,
    ProgressStatus? progressStatus
  }) => ProgressState(
    progress: progress ?? this.progress,
    progressStatus: progressStatus ?? this.progressStatus
  );


  @override
  List<Object?> get props => [progress, progressStatus];
} 

class ProgressError extends ProgressState {
  final String message;

  ProgressError({required this.message});

}


