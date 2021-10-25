import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

// ignore: constant_identifier_names
const BASE_URL = 'https://api.infinum.academy/api/';

class DioHttpService extends BaseHttpService {
  DioHttpService(this.dio, this.storageService, {String baseUrl = BASE_URL}) {
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
        onError: (DioError error, handler) async {},
      ),
    );
  }

  final Dio dio;
  final StorageService storageService;

  String? get _token {
    try {
      final response = storageService.getToken();
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<dynamic> delete({
    required BaseHttpRequest request,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> get({
    required BaseHttpRequest request,
  }) async {
    final map = request.toMap();
    final options = Options(
      contentType: Headers.jsonContentType,
    );
    final response = await dio.get<dynamic>(
      request.endpoint,
      queryParameters: map,
      options: options,
    );
    return jsonDecode(response.data! as String);
  }

  @override
  Future<dynamic> post({
    required BaseHttpRequest request,
  }) async {
    final map = request.toMap();
    final options = Options(
      contentType: Headers.jsonContentType,
    );
    final response = await dio.post<String>(
      request.endpoint,
      data: jsonEncode(map),
      options: options,
    );

    return jsonDecode(response.data!);
  }
}
