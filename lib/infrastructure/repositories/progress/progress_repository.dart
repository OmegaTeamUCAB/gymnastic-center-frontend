import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';
import 'package:gymnastic_center/domain/progress/progress_repository.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class ProgressRepository extends IProgressRepository {
  final IHttpManager _httpConnectionManager;

  ProgressRepository(this._httpConnectionManager);

  @override
  Future<Result<Progress>> getCourseProgressById(String courseId) async {
    final response = await _httpConnectionManager.makeRequest(
      urlPath: '/progress/one/$courseId',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<LessonProgress> lessonProgress = [];
        for(var lesson in data["lessons"]) {
          lessonProgress.add(
            LessonProgress(
          lessonId: lesson["lessonId"], 
          time: lesson["time"], 
          percent: (lesson["percent"] as num).toDouble() 
        )
          );
        }
        final progress = Progress( 
          lessonProgress: lessonProgress,
        percent: (data["percent"] as num).toDouble()
        );
        return progress;
      },
    );
    return response;

  }


  @override
  Future<Result<String>> startCourseProgress(String courseId) async {
    final response = await _httpConnectionManager.makeRequest(
      urlPath: '/progress/start/$courseId',
      httpMethod: 'POST',
      mapperCallBack: (data) => data["id"] as String,
    );
    return response;
  }


  @override
  Future<Result<String>> updateCourseProgress(UpdateProgressDTO dto) async {
    var body = {
      'courseId': dto.courseId.toString(),
      'lessonId': dto.lessonId.toString(),
      'markAsCompleted': dto.markAsCompleted,
      'time': dto.time.toInt(),
      'totalTime': dto.totalTime.toInt()
    };
    final response = await _httpConnectionManager.makeRequest(
      urlPath: 'progress/mark/end',
      httpMethod: 'POST',
      body: body,
      mapperCallBack: (data) => data["id"] as String,
    );
    return response;
  }
  
  @override
  Future<Result<List<CourseProgress>>> getWatchingCourses(WatchingProgressDTO dto) async {
      var queryParameters = {
      'page': dto.page.toString(),
      'perPage': dto.perPage.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;
    final response = await _httpConnectionManager.makeRequest(
      urlPath: '/progress/courses?$queryString',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<CourseProgress> courses = [];
        for (var course in data) {
          courses.add(CourseProgress(
            course: Course(
              id: course['id'],
              imageUrl: course['image'],
              category: course['category'],
              name: course['title'],
              trainer: course['trainer'],
              createdAt: course['date'],
            ),
            percent: course["percent"] 

          ));
        }
        return courses;
      },);
    return response;
  }
}
