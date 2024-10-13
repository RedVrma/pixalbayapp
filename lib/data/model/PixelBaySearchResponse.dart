import 'PixelBayImageModel.dart';

class PixelBaySearchResponse {
  final int total;
  final int totalHits;
  final List<PixelBayImageModel> hits;

  PixelBaySearchResponse({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory PixelBaySearchResponse.fromJson(Map<String, dynamic> json) {
    return PixelBaySearchResponse(
      total: json['total'],
      totalHits: json['totalHits'],
      hits: (json['hits'] as List)
          .map((item) => PixelBayImageModel.fromJson(item))
          .toList(),
    );
  }
}
