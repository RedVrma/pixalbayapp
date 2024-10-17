import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixalbayapp/data/api/ImageService.dart';
import 'package:pixalbayapp/data/model/PixelBayImageModel.dart';
import 'package:pixalbayapp/data/model/PixelBaySearchResponse.dart';

class PixelBayService implements ImageService {
  final String apiKey;
  final String baseUrl;
  final Dio _dio;

  PixelBayService({required apiClient})
      : _dio = apiClient,
        apiKey = dotenv.env["PIXEL_BAY_API_KEY"] ?? "",
        baseUrl = dotenv.env["PIXEL_BAY_BASEURL"] ?? "";

  @override
  Future<List<PixelBayImageModel>> searchImagesOnPixelBay(
      String query, int perPage, int pageNumber) async {
    try {
      final response = await _dio.get("https://workers-playground-shrill-scene-e6ad.vpuneetwork.workers.dev/pixabayFetch",
          queryParameters: {
            'key': apiKey,
            'q': query,
            'per_page': perPage,
            'page': pageNumber
          },
      );

      if (response.statusCode == 200) {
        final res = PixelBaySearchResponse.fromJson(response.data);
        return res.hits;
      } else {
        throw Exception(
            'Failed to load images ${response.statusCode} ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Error ${e.response?.statusCode} ${e.message}');
        }
      } else {
        throw Exception("Failed to load images ${e.response} ${e.message}");
      }
    }

    return List.empty();
  }
}
