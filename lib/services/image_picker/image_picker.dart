import 'package:dio/dio.dart';

abstract class ImagePickerService {
  Future<FormData> getFormDataFromImage();
}
