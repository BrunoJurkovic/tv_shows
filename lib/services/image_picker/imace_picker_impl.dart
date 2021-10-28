import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tv_shows/services/image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImagePickerImpl implements ImagePickerService {
  ImagePickerImpl({required this.picker, required this.uuid});

  final ImagePicker picker;
  final Uuid uuid;

  @override
  Future<FormData> getFormDataFromImage() async {
    final imagePath = await _pickImagePath();
    final fileName = uuid.v1();
    final formData = FormData.fromMap(
      <String, dynamic>{
        'file': await MultipartFile.fromFile(imagePath, filename: fileName),
      },
    );
    return formData;
  }

  Future<String> _pickImagePath() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) throw Exception();
    return image.path;
  }
}
