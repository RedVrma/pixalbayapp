class PixelBayImageModel {
  final int id;
  final String? pageURL;
  final String? type;
  final String? tags;
  final String? previewURL;
  final int previewWidth;
  final int previewHeight;
  final String? webformatURL;
  final int webformatWidth;
  final int webformatHeight;
  final String? largeImageURL;
  final String? fullHDURL;
  final String? imageURL;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final int userId;
  final String? user;
  final String? userImageURL;

  PixelBayImageModel({
    required this.id,
    this.pageURL,
    this.type,
    this.tags,
    this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    this.webformatURL,
    required this.webformatWidth,
    required this.webformatHeight,
    this.largeImageURL,
    this.fullHDURL,
    this.imageURL,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.userId,
    this.user,
    this.userImageURL,
  });

  factory PixelBayImageModel.fromJson(Map<String, dynamic> json) {
    return PixelBayImageModel(
      id: json['id'],
      pageURL: json['pageURL'],
      type: json['type'],
      tags: json['tags'],
      previewURL: json['previewURL'],
      previewWidth: json['previewWidth'],
      previewHeight: json['previewHeight'],
      webformatURL: json['webformatURL'],
      webformatWidth: json['webformatWidth'],
      webformatHeight: json['webformatHeight'],
      largeImageURL: json['largeImageURL'],
      fullHDURL: json['fullHDURL'],
      imageURL: json['imageURL'],
      imageWidth: json['imageWidth'],
      imageHeight: json['imageHeight'],
      imageSize: json['imageSize'],
      views: json['views'],
      downloads: json['downloads'],
      likes: json['likes'],
      comments: json['comments'],
      userId: json['user_id'],
      user: json['user'],
      userImageURL: json['userImageURL'],
    );
  }
}
