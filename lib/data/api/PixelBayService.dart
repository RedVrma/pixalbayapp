import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixalbayapp/data/model/PixelBayImageModel.dart';
import 'package:pixalbayapp/data/model/PixelBaySearchResponse.dart';

class PixelBayService {
  final String api_key;
  final String base_url = "https://pixabay.com/api";
  Dio _dio;

  PixelBayService({required apiClient})
      : _dio = apiClient,
        api_key = dotenv.env["PIXEL_BAY_API_KEY"] ?? "";

  Future<List<PixelBayImageModel>> fetchImages(
      String query, int perPage, int pageNumber) async {
    try {
      final response = await _dio.get(base_url, queryParameters: {
        'key': api_key,
        'q': query,
        'image_type': "photo",
        'per_page': perPage,
        'page': pageNumber
      });

      if (response.statusCode == 200) {
        final res = PixelBaySearchResponse.fromJson(response.data);
        return res.hits;
      } else {
        print('Error ${response?.statusCode}');

        throw Exception('Failed to load images');
      }
    } on DioException catch (e, s) {
      if (e.response != null) {
        print('Error ${e.response?.statusCode} ${e.message}');
      } else {
        throw Exception("Failed to load images ${e.response} ${e.message}");
      }
    }

    return List.empty();
  }
}
