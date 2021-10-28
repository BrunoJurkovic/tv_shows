import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<FormData> getFormDataFromImage();
}
