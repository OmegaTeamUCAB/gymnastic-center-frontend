import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/application/blocs/notifications/notifications_bloc.dart';
import 'package:gymnastic_center/application/blocs/theme/theme_bloc.dart';
import 'package:gymnastic_center/application/use_cases/auth/get_user_from_token.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/login.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/logout.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/sign_up.use_case.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blog_by_id.use_case.dart';
import 'package:gymnastic_center/firebase_options.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/data-sources/local/secure_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blogs_service.dart';
import 'package:gymnastic_center/infrastructure/repositories/categories/category_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/course_repository.dart';
import 'package:gymnastic_center/infrastructure/repositories/search/search_repository.dart';
import 'package:gymnastic_center/infrastructure/services/firebase/firebase_handler.dart';
import 'package:gymnastic_center/infrastructure/services/notifications/notification_handler.dart';

class IoCContainer {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final getIt = GetIt.instance;
    await Environment.initEnvironment();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final httpConnectionManager =
        HttpManagerImpl(baseUrl: Environment.getApiUrl());
    final secureStorage = SecureStorage();
    //REPOSITORIES
    final authRepository = AuthRepository(httpConnectionManager, secureStorage);
    final blogRepository = BlogsRepository(httpConnectionManager);
    final categoryRepository = CategoryRepository();
    final courseRepository = CourseRepository();
    final searchRepository = SearchRepository();
    //USE CASES
    final getUserFromTokenUseCase =
        GetUserFromTokenUseCase(authRepository, secureStorage);
    final loginUseCase = LoginUseCase(authRepository, secureStorage);
    final logoutUseCase = LogoutUseCase(localDataSource: secureStorage);
    final signUpUseCase = SignUpUseCase(authRepository, secureStorage);
    final getBlogByIdUseCase = GetBlogByIdUseCase(blogRepository);
    getIt.registerSingleton<GetBlogByIdUseCase>(getBlogByIdUseCase);
    //BLOCS
    getIt.registerSingleton<AuthBloc>(AuthBloc(
        logoutUseCase: logoutUseCase,
        loginUseCase: loginUseCase,
        signUpUseCase: signUpUseCase,
        getUserFromTokenUseCase: getUserFromTokenUseCase));
    getIt.registerSingleton<BlogDetailBloc>(
        BlogDetailBloc(getBlogUseCase: getBlogByIdUseCase));
    getIt.registerSingleton<NotificationsBloc>(NotificationsBloc(
        handler: NotificationHandler()..initializeLocalNotifications()));
    getIt.registerSingleton<ThemeBloc>(ThemeBloc());
    getIt.registerSingleton<CourseBloc>(CourseBloc(courseRepository));
  }
}
