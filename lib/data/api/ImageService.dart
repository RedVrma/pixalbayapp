


import 'package:pixalbayapp/data/model/PixelBayImageModel.dart';

abstract class ImageService{

  Future<List<PixelBayImageModel>> searchImagesOnPixelBay(String query, int perPage, int pageNumber);

}