import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/services/image_picker/imace_picker_impl.dart';
import 'package:tv_shows/services/image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'imace_picker_impl_test.mocks.dart';

@GenerateMocks([ImagePicker])
void main() {
  late ImagePickerService imagePickerService;
  late Uuid uuid;
  late ImagePicker imagePicker;

  setUpAll(() {
    uuid = const Uuid();
    imagePicker = MockImagePicker();
    imagePickerService = ImagePickerImpl(picker: imagePicker, uuid: uuid);
  });
  test(
    'should return formdata type when getFormDataFromImage() is called',
    () async {
      // arrange
      /// We have to get a path to a test image otherwise the test throws an
      /// error when converting to a MultiPartFile and later on to FormData.
      final tempPath = '${Directory.current}';
      final path = tempPath
          .replaceAll(RegExp("'"), '')
          .replaceAll(RegExp('Directory: '), '');

      when(
        imagePicker.pickImage(source: ImageSource.gallery),
      ).thenAnswer(
        (realInvocation) async => XFile('$path/test/resources/logo.png'),
      );
      // act
      final result = await imagePickerService.getFormDataFromImage();
      // assert
      expect(result, isA<FormData>());
    },
  );
  test('throw Exception when the user does not pick an image', () async {
    // arrange
    when(
      imagePicker.pickImage(source: ImageSource.gallery),
    ).thenAnswer(
      (realInvocation) async => null,
    );
    // act
    final result = imagePickerService.getFormDataFromImage();
    // assert
    expect(result, throwsA(isA<Exception>()));
  });
}
