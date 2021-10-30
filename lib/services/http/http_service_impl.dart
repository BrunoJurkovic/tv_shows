import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/utils/media_utils.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/storage/storage_service.dart';

// ignore: constant_identifier_names
const BASE_URL = 'https://api.infinum.academy/';

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
        onError: (DioError error, handler) async {
          return handler.next(error);
        },
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
    final response = await dio.get<dynamic>(
      request.endpoint,
      options: options,
    );
    return response.data;
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
      rethrow;
    } catch (e) {
      throw Exception();
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
      throw Exception();
    }
  }
}
