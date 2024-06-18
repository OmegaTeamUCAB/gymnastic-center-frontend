import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/all_blogs/all_blogs_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_categories/all_categories_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_courses/all_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_trainers/all_trainers_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/application/blocs/courses_by_category/courses_by_category_bloc.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/notifications/notifications_bloc.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/application/blocs/select_data_source/select_data_source_bloc.dart';
import 'package:gymnastic_center/application/blocs/theme/theme_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/application/blocs/trainer_detail/trainer_detail_bloc.dart';
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
import 'package:gymnastic_center/application/use_cases/course/get_course_by_id.use_case.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses.use_case.dart';
import 'package:gymnastic_center/application/use_cases/search/search.use_case.dart';
import 'package:gymnastic_center/application/use_cases/trainer/get_trainer_by_id.use_case.dart';
import 'package:gymnastic_center/application/use_cases/trainer/get_trainers.use_case.dart';
import 'package:gymnastic_center/firebase_options.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/data-sources/local/secure_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blog_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/categories/category_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/course_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/search/search_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/trainer/trainer_repository.dart';
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
    final httpConnectionManager =
        HttpManagerImpl();
    final secureStorage = SecureStorage();
    //REPOSITORIES
    final authRepository = AuthRepository(httpConnectionManager, secureStorage);
    final blogRepository = BlogsRepository(httpConnectionManager);
    final categoryRepository = CategoryRepository(httpConnectionManager);
    final courseRepository = CourseRepository(httpConnectionManager);
    final searchRepository = SearchRepository(httpConnectionManager);
    final trainerRepository = TrainerRepository(httpConnectionManager);
    //USE CASES
    final getUserFromTokenUseCase = GetUserFromTokenUseCase(authRepository);
    final loginUseCase = LoginUseCase(authRepository, secureStorage);
    final logoutUseCase = LogoutUseCase(authRepository);
    final signUpUseCase = SignUpUseCase(authRepository, secureStorage);
    final requestCodeUseCase = RequestCodeUseCase(authRepository);
    final resetPasswordUseCase = ResetPasswordUseCase(authRepository);
    final verifyCodeUseCase = VerifyCodeUseCase(authRepository);
    final getBlogByIdUseCase = GetBlogByIdUseCase(blogRepository);
    final getBlogsUseCase = GetBlogsUseCase(blogRepository);
    final getAllCategoriesUseCase = GetAllCategoriesUseCase(categoryRepository);
    final getCoursesUseCase = GetCoursesUseCase(courseRepository);
    final searchUseCase = SearchUseCase(searchRepository);
    getIt.registerSingleton<GetCourseByIdUseCase>(
        GetCourseByIdUseCase(courseRepository));
    final getTrainerByIdUseCase = GetTrainerByIdUseCase(trainerRepository);
    final getTrainersUseCase = GetTrainersUseCase(trainerRepository);
    //BLOCS
    getIt.registerSingleton<BlogsByCategoryBloc>(
        BlogsByCategoryBloc(getBlogsUseCase: getBlogsUseCase));
    getIt.registerSingleton<AllCoursesBloc>(AllCoursesBloc(getCoursesUseCase));
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
    getIt.registerSingleton<NotificationsBloc>(NotificationsBloc(
        handler: NotificationHandler()..initializeLocalNotifications()));
    getIt.registerSingleton<ThemeBloc>(ThemeBloc());
    getIt.registerSingleton<CourseBloc>(CourseBloc(courseRepository));
    getIt.registerSingleton<LessonBloc>(LessonBloc());
    getIt.registerSingleton<VideoPlayerBloc>(VideoPlayerBloc());
    getIt.registerSingleton<SelectDataSourceBloc>(selectDataSourceBloc);
  }
}
