import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gymnastic_center/application/blocs/brand_notifications/brand_notifications_bloc.dart';
import 'package:gymnastic_center/application/blocs/course_detail/course_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/feature_courses/feature_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/get_search_tags/get_search_tags_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/application/blocs/viewed_courses/viewed_courses_bloc.dart';
import 'package:gymnastic_center/application/use_cases/notifications/delete_notifications.use_case.dart';
import 'package:gymnastic_center/application/use_cases/notifications/get_notifications.use_case.dart';
import 'package:gymnastic_center/application/use_cases/notifications/read_notification.use_case.dart';
import 'package:gymnastic_center/application/use_cases/progress/get_course_progess.use_case.dart';
import 'package:gymnastic_center/application/use_cases/progress/get_viewed_courses.use_case.dart';
import 'package:gymnastic_center/application/use_cases/progress/start_course_progess.use_case.dart';
import 'package:gymnastic_center/application/use_cases/progress/update_course_progess.use_case.dart';
import 'package:gymnastic_center/application/use_cases/search/get_search_tags.use_case.dart';
import 'package:gymnastic_center/application/blocs/delete_comment/delete_comment_bloc.dart';
import 'package:gymnastic_center/application/blocs/popular_blogs/popular_blogs_bloc.dart';
import 'package:gymnastic_center/application/use_cases/comment/delete_comment.use_case.dart';
import 'package:gymnastic_center/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gymnastic_center/application/blocs/all_blogs/all_blogs_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_blogs_by_trainer/all_blogs_by_trainer_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_categories/all_categories_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_course_by_trainer/all_course_by_trainer_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_courses/all_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_trainers/all_trainers_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/trainer_user_follow/trainer_user_follow_bloc.dart';
import 'package:gymnastic_center/application/blocs/get_comments/get_comments_bloc.dart';
import 'package:gymnastic_center/application/blocs/follow_trainer/follow_trainer_bloc.dart';
import 'package:gymnastic_center/application/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/application/blocs/courses_by_category/courses_by_category_bloc.dart';
import 'package:gymnastic_center/application/blocs/create_comment/create_comment_bloc.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/like_or_dislike_comment/like_or_dislike_comment_bloc.dart';
import 'package:gymnastic_center/application/blocs/notifications/notifications_bloc.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/application/blocs/select_data_source/select_data_source_bloc.dart';
import 'package:gymnastic_center/application/blocs/theme/theme_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/application/blocs/trainer_detail/trainer_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/update_user/update_user_bloc.dart';
import 'package:gymnastic_center/application/use_cases/auth/get_user_from_token.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/login.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/logout.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/request_code.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/reset_password.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/sign_up.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/verify_code.use_case.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blogs.use_case.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blog_by_id.use_case.dart';
import 'package:gymnastic_center/application/use_cases/category/get_all_categories.use_case.dart';
import 'package:gymnastic_center/application/use_cases/comment/create_comment.use_case.dart';
import 'package:gymnastic_center/application/use_cases/comment/get_comments.use_case.dart';
import 'package:gymnastic_center/application/use_cases/comment/like_or_dislike_comment.use_case.dart';
import 'package:gymnastic_center/application/use_cases/course/get_course_by_id.use_case.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses.use_case.dart';
import 'package:gymnastic_center/application/use_cases/search/search.use_case.dart';
import 'package:gymnastic_center/application/use_cases/trainer/follow_trainer.use_case.dart';
import 'package:gymnastic_center/application/use_cases/trainer/get_trainer_by_id.use_case.dart';
import 'package:gymnastic_center/application/use_cases/user/update_user.use_case.dart';
import 'package:gymnastic_center/application/use_cases/trainer/get_trainers.use_case.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/data-sources/local/secure_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/application/use_cases/user/trainer_user_follow.use_case.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blog_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/categories/category_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/comments/comment_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/course_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/progress/progress_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/search/search_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/trainer/trainer_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/user/user_repository.dart';
import 'package:gymnastic_center/infrastructure/services/firebase/firebase_handler.dart';
import 'package:gymnastic_center/infrastructure/services/notifications/notification_handler.dart';

class IoCContainer {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final getIt = GetIt.instance;
    final selectDataSourceBloc = SelectDataSourceBloc();
    await Environment.initEnvironment(selectDataSourceBloc);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final httpConnectionManager = HttpManagerImpl();
    final secureStorage = SecureStorage();
    getIt.registerSingleton<SecureStorage>(secureStorage);
    final String? onBoardingValue = await secureStorage.getValue('onboarding');
    final bool hasCompletedOnBoarding =
        (onBoardingValue == null) ? false : true;
    getIt.registerSingleton<bool>(hasCompletedOnBoarding);
    //REPOSITORIES
    final authRepository = AuthRepository(httpConnectionManager, secureStorage);
    final blogRepository = BlogsRepository(httpConnectionManager);
    final categoryRepository = CategoryRepository(httpConnectionManager);
    final courseRepository = CourseRepository(httpConnectionManager);
    final searchRepository = SearchRepository(httpConnectionManager);
    final userRepository = UserRepository(httpConnectionManager);
    final trainerRepository = TrainerRepository(httpConnectionManager);
    final commentRepository = CommentRepository(httpConnectionManager);
    final notificationRepository =
        NotificationRepository(httpConnectionManager);
    final progressRepository = ProgressRepository(httpConnectionManager);

    //USE CASES
    final getUserFromTokenUseCase = GetUserFromTokenUseCase(authRepository);
    final loginUseCase =
        LoginUseCase(authRepository, notificationRepository, secureStorage);
    final logoutUseCase = LogoutUseCase(authRepository, notificationRepository);
    final getCourseByIdUseCase = GetCourseByIdUseCase(courseRepository);
    final signUpUseCase =
        SignUpUseCase(authRepository, notificationRepository, secureStorage);
    final requestCodeUseCase = RequestCodeUseCase(authRepository);
    final resetPasswordUseCase = ResetPasswordUseCase(authRepository);
    final verifyCodeUseCase = VerifyCodeUseCase(authRepository);
    final getBlogByIdUseCase = GetBlogByIdUseCase(blogRepository);
    final getBlogsUseCase = GetBlogsUseCase(blogRepository);
    final getAllCategoriesUseCase = GetAllCategoriesUseCase(categoryRepository);
    final getCoursesUseCase = GetCoursesUseCase(courseRepository);
    final searchUseCase = SearchUseCase(searchRepository);
    final getViewedCoursesUseCase = GetViewedCoursesUseCase(progressRepository);
    getIt.registerSingleton<GetCourseByIdUseCase>(
        GetCourseByIdUseCase(courseRepository));
    final getTrainerByIdUseCase = GetTrainerByIdUseCase(trainerRepository);
    final updateUserUseCase = UpdateUserUseCase(userRepository);
    final trainerUserFollowUseCase = TrainerUserFollowUseCase(userRepository);
    final getTrainersUseCase = GetTrainersUseCase(trainerRepository);
    final getBlogCommentsUseCase = GetCommentsUseCase(commentRepository);
    final getSearchTagsUseCase = GetSearchTagsUseCase(searchRepository);
    final createCommentUseCase = CreateCommentUseCase(commentRepository);
    final deleteCommentUseCase = DeleteCommentUseCase(commentRepository);
    final followTrainerUseCase = FollowTrainersUseCase(trainerRepository);
    final getNotificationsUseCase =
        GetNotificationsUseCase(notificationRepository);
    final readNotificationsUseCase =
        ReadNotificationUseCase(notificationRepository);
    final deleteNotificationsUseCase =
        DeleteNotificationsUseCase(notificationRepository);
    final likeOrDislikeCommentUseCase =
        LikeOrDislikeCommentUseCase(commentRepository);
    final startCourseProgressUseCase =
        StartCourseProgressUseCase(progressRepository);
    final getCourseProgressByIdUseCase =
        GetCourseProgressByIdUseCase(progressRepository);
    final updateCourseProgressUseCase =
        UpdateCourseProgressUseCase(progressRepository);

    //BLOCS
    getIt.registerSingleton<BrandNotificationsBloc>(BrandNotificationsBloc(
        getNotificationsUseCase,
        readNotificationsUseCase,
        deleteNotificationsUseCase));
    getIt.registerSingleton<GetCommentsBloc>(
        GetCommentsBloc(getBlogCommentsUseCase));
    getIt.registerSingleton<ViewedCoursesBloc>(
        ViewedCoursesBloc(getViewedCoursesUseCase));
    getIt.registerSingleton<CreateCommentBloc>(
        CreateCommentBloc(createCommentUseCase));
    getIt.registerSingleton<DeleteCommentBloc>(
        DeleteCommentBloc(deleteCommentUseCase));
    getIt.registerSingleton<BlogsByCategoryBloc>(
        BlogsByCategoryBloc(getBlogsUseCase: getBlogsUseCase));
    getIt
        .registerSingleton<PopularBlogsBloc>(PopularBlogsBloc(getBlogsUseCase));
    getIt.registerSingleton<AllCoursesBloc>(AllCoursesBloc(getCoursesUseCase));
    getIt.registerSingleton<FeatureCoursesBloc>(
        FeatureCoursesBloc(getCoursesUseCase));
    getIt.registerSingleton<AllCourseByTrainerBloc>(
        AllCourseByTrainerBloc(getCoursesUseCase));
    getIt.registerSingleton<AllBlogsByTrainerBloc>(
        AllBlogsByTrainerBloc(getBlogsUseCase));
    getIt.registerSingleton<GetSearchTagsBloc>(
        GetSearchTagsBloc(getSearchTagsUseCase));
    getIt.registerSingleton<CourseDetailBloc>(
        CourseDetailBloc(getCourseByIdUseCase));
    getIt
        .registerSingleton<PlanCoursesBloc>(PlanCoursesBloc(getCoursesUseCase));
    getIt.registerSingleton<CoursesByCategoryBloc>(
        CoursesByCategoryBloc(getCoursesUseCase));
    getIt.registerSingleton<AllCategoriesBloc>(
        AllCategoriesBloc(getAllCategoriesUseCase));
    getIt.registerSingleton<AllBlogsBloc>(AllBlogsBloc(getBlogsUseCase));
    getIt.registerSingleton<AuthBloc>(AuthBloc(
      logoutUseCase: logoutUseCase,
      loginUseCase: loginUseCase,
      signUpUseCase: signUpUseCase,
      requestCodeUseCase: requestCodeUseCase,
      verifyCodeUseCase: verifyCodeUseCase,
      resetPasswordUseCase: resetPasswordUseCase,
      getUserFromTokenUseCase: getUserFromTokenUseCase,
    ));
    getIt.registerSingleton<SearchBloc>(SearchBloc(searchUseCase));
    getIt.registerSingleton<BlogDetailBloc>(BlogDetailBloc(getBlogByIdUseCase));
    getIt.registerSingleton(TrainerDetailBloc(getTrainerByIdUseCase));
    getIt.registerSingleton<AllTrainersBloc>(
        AllTrainersBloc(getTrainersUseCase));
    getIt.registerSingleton<FollowTrainerBloc>(
        FollowTrainerBloc(followTrainerUseCase));
    getIt.registerSingleton<LikeOrDislikeCommentBloc>(LikeOrDislikeCommentBloc(
        commentRepository, likeOrDislikeCommentUseCase));
    getIt.registerSingleton<NotificationsBloc>(NotificationsBloc(
        handler: NotificationHandler()..initializeLocalNotifications()));
    getIt.registerSingleton<ThemeBloc>(ThemeBloc());
    getIt.registerSingleton<CourseBloc>(CourseBloc(courseRepository));
    getIt.registerSingleton<UpdateUserBloc>(UpdateUserBloc(updateUserUseCase));
    getIt.registerSingleton<TrainerUserFollowBloc>(
        TrainerUserFollowBloc(trainerUserFollowUseCase));
    getIt.registerSingleton<LessonBloc>(LessonBloc());
    getIt.registerSingleton<ProgressBloc>(ProgressBloc(
        getCourseProgressByIdUseCase: getCourseProgressByIdUseCase,
        startCourseProgressUseCase: startCourseProgressUseCase,
        updateCourseProgressUseCase: updateCourseProgressUseCase));
    getIt.registerSingleton<VideoPlayerBloc>(VideoPlayerBloc());
    getIt.registerSingleton<SelectDataSourceBloc>(selectDataSourceBloc);
  }
}
