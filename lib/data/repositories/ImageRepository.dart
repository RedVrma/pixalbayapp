import 'package:pixalbayapp/data/api/ImageService.dart';
import 'package:pixalbayapp/data/model/PixelBayImageModel.dart';

class ImageRepository {
  ImageRepository(this._imageService);

  final ImageService _imageService;

  Future<List<PixelBayImageModel>> searchImages(String query, int pageNumber, int perPage) async {
    return await _imageService.searchImagesOnPixelBay(query, perPage, pageNumber);
  }

}
