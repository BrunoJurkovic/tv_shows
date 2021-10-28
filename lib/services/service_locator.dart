// ignore_for_file: cascade_invocations

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_shows/business_logic/viewmodels/comment_viewmodel.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/business_logic/viewmodels/shows_viemodel.dart';
import 'package:tv_shows/services/auth/auth.dart';
import 'package:tv_shows/services/auth/auth_impl.dart';
import 'package:tv_shows/services/comment/comment_service.dart';
import 'package:tv_shows/services/comment/comment_service_impl.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/http/http_service_impl.dart';
import 'package:tv_shows/services/shows/shows_service.dart';
import 'package:tv_shows/services/shows/shows_service_impl.dart';
import 'package:tv_shows/services/storage/storage_service.dart';
import 'package:tv_shows/services/storage/storage_service_impl.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setUpLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
  serviceLocator.registerLazySingleton<StorageService>(
    () => StorageServiceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseHttpService>(
    () => DioHttpService(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<Dio>(
    () => Dio(),
  );
  serviceLocator.registerLazySingleton<AuthenticationService>(
    () => AuthenticationServiceImpl(
      storageService: serviceLocator(),
      httpService: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<LoginViewModel>(
    () => LoginViewModel(
      authenticationService: serviceLocator(),
      storageService: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ShowsService>(
    () => ShowsServiceImpl(
      httpService: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ShowsViewModel>(
    () => ShowsViewModel(
      showsService: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<CommentViewModel>(
    () => CommentViewModel(
      commentService: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<CommentService>(
    () => CommentServiceImpl(
      httpService: serviceLocator(),
    ),
  );
}
