import 'package:tv_shows/business_logic/models/episode.dart';
import 'package:tv_shows/business_logic/models/image_data.dart';
import 'package:tv_shows/business_logic/utils/episode_utils.dart';
import 'package:tv_shows/business_logic/utils/media_utils.dart';
import 'package:tv_shows/services/episodes/episodes_service.dart';
import 'package:tv_shows/services/http/http_service.dart';
import 'package:tv_shows/services/image_picker/image_picker.dart';

class EpisodeServiceImpl implements EpisodeService {
  EpisodeServiceImpl({
    required this.httpService,
    required this.imagePickerService,
  });

  final BaseHttpService httpService;
  final ImagePickerService imagePickerService;

  @override
  Future<Episode> getEpisodeById(String id) async {
    final response = await httpService.get(
      request: EpisodeRequest(id),
    ) as Map<String, dynamic>;
    final result = EpisodeResponse.fromMap(response);
    return Episode(
      episodeId: result.episodeId,
      title: result.title,
      description: result.description,
      episodeNumber: result.episodeNumber,
      season: result.season,
      imageUrl: result.imageUrl,
    );
  }

  @override
  Future<void> uploadEpisode({
    required String showId,
    required String title,
    required String description,
    required String episodeNumber,
    required String season,
    required String mediaId,
  }) async {
    try {
      await httpService.post(
        request: AddEpisodeRequest(
          showId: showId,
          mediaId: mediaId,
          title: title,
          description: description,
          episodeNumber: episodeNumber,
          season: season,
        ),
      ) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ImageData> uploadImage() async {
    final formData = await imagePickerService.getFormDataFromImage();
    final response = await httpService.postFormData(
      request: MediaRequest(formData),
    ) as Map<String, dynamic>;
    final result = MediaResponse.fromMap(response);
    return ImageData(imageUrl: result.imagePath, mediaId: result.mediaId);
  }
}
