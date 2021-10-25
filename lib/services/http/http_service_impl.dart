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
    dio.options.receiveTimeout = 50000;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          final token = _token;
          options.headers.addAll(
            <String, String>{'Authorization': token ?? ''},
          );
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
    final response = await dio.get<String>(
      request.endpoint,
      queryParameters: map,
    );

    return jsonDecode(response.data!);
  }

  @override
  Future<dynamic> post({
    required BaseHttpRequest request,
  }) async {
    final map = request.toMap();
    final response = await dio.post<String>(
      request.endpoint,
      queryParameters: map,
    );

    return jsonDecode(response.data!);
  }
}
