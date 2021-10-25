// ignore_for_file: cascade_invocations

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/services/auth/auth.dart';
import 'package:tv_shows/services/auth/auth_impl.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/http/http_service_impl.dart';
import 'package:tv_shows/services/storage/storage_service.dart';
import 'package:tv_shows/services/storage/storage_service_impl.dart';

GetIt serviceLocator = GetIt.instance;

void setUpLocator() {
  serviceLocator.registerLazySingletonAsync<SharedPreferences>(
    () async => SharedPreferences.getInstance(),
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
    ),
  );
}
