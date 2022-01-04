import 'package:minervafrontend/constants.dart';
import 'package:minervafrontend/controller/api_controller.dart';
import 'package:minervafrontend/model/l_response.dart';
import 'package:minervafrontend/model/songs_provider.dart';

class SongApiController extends APIController {
  SongApiController() : super(baseUrl: kBaseUrl);

  Future<LResponse<List<Song>?>> fetchPlayList(
      {required int start, required int count}) async {
    final LResponse<List<Song>?> lResponse = getDefaultLResponse<List<Song>?>();

    await withTryBlock(
        lResponse: lResponse,
        codeToHandle: () async {
          final response = await dio.get('/playlist', queryParameters: {
            'start': start,
            'count': count,
          });
          if (getStatus(response)) {
            final List<Song> songs = [];
            final List data = getData(response);
            for (var element in data) {
              songs.add(Song.fromJson(element));
            }
            lResponse.data = songs;
            lResponse.responseStatus = ResponseStatus.success;
            lResponse.message = 'Success';
          } else {
            lResponse.responseStatus = ResponseStatus.failed;
            lResponse.message = response.data?.toString() ?? '';
          }
        });

    return lResponse;
  }

  Future<LResponse<Song?>> searchSongByTitle(String title) async {
    final LResponse<Song?> lResponse = getDefaultLResponse<Song?>();

    await withTryBlock(
        lResponse: lResponse,
        codeToHandle: () async {
          final response = await dio.get('/find-song', queryParameters: {
            'title': title,
          });
          if (getStatus(response)) {
            lResponse.data =
                Song.fromJson(getData<Map<String, dynamic>>(response));
            lResponse.responseStatus = ResponseStatus.success;
            lResponse.message = 'Success';
          } else {
            lResponse.responseStatus = ResponseStatus.failed;
            lResponse.message = response.data?.toString() ?? '';
          }
        });

    return lResponse;
  }

  Future<LResponse<Song?>> updateRating(
      {required int index, required double ratingValue}) async {
    final LResponse<Song?> lResponse = getDefaultLResponse<Song?>();

    await withTryBlock(
        lResponse: lResponse,
        codeToHandle: () async {
          final response = await dio.put('/star-rating',
              data: {'index': index, 'star_rating': ratingValue});

          if (getStatus(response)) {
            lResponse.responseStatus = ResponseStatus.success;
            lResponse.message = 'Success';
          } else {
            lResponse.responseStatus = ResponseStatus.failed;
            lResponse.message = response.data?.toString() ?? '';
          }
        });

    return lResponse;
  }
}
