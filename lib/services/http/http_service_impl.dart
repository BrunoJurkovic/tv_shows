import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tv_shows/business_logic/exceptions/exceptions.dart';
import 'package:tv_shows/business_logic/utils/media_utils.dart';
import 'package:tv_shows/services/hot_storage/hot_storage.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

// ignore: constant_identifier_names
const BASE_URL = 'https://api.infinum.academy/';

class DioHttpService extends BaseHttpService {
  DioHttpService(this.dio, this.storageService, this.hotStorageService,
      {String baseUrl = BASE_URL}) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 200000; // 5s
    dio.options.receiveTimeout = 500000;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          final token = _token;
          if (token != null) {
            options.headers.addAll(
              <String, String>{'Authorization': token},
            );
          }
          return handler.next(options);
        },
        onResponse: (Response response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) async {
          return handler.next(error);
        },
      ),
    );
  }

  final Dio dio;
  final StorageService storageService;
  final HotStorageService hotStorageService;

  String? get _token {
    if (storageService.getToken() != '') {
      return storageService.getToken();
    }
    return hotStorageService.token;
  }

  @override
  Future<dynamic> delete({
    required BaseHttpDeleteRequest request,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> get({
    required BaseHttpGetRequest request,
  }) async {
    final options = Options(
      contentType: Headers.jsonContentType,
    );
    try {
      final response = await dio.get<dynamic>(
        request.endpoint,
        options: options,
      );
      return response.data;
    } catch (e) {
      throw HttpException();
    }
  }

  @override
  Future<dynamic> post({
    required BaseHttpPostRequest request,
  }) async {
    final map = request.toMap();
    final options = Options(
      contentType: Headers.jsonContentType,
    );
    try {
      final response = await dio.post<String>(
        request.endpoint,
        data: map,
        options: options,
      );
      return jsonDecode(response.data!);
    } on DioError {
      throw Exception();
    } catch (e) {
      throw HttpException();
    }
  }

  @override
  Future<dynamic> postFormData({
    required MediaRequest request,
  }) async {
    try {
      final response = await dio.post<String>(
        request.endpoint,
        data: request.formData,
      );
      return jsonDecode(response.data!);
    } on DioError {
      rethrow;
    } catch (e) {
      throw HttpException();
    }
  }
}
