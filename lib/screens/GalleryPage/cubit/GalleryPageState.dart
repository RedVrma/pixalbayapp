import 'package:equatable/equatable.dart';
import 'package:pixalbayapp/data/model/PixelBayImageModel.dart';

abstract class GalleryPageState extends Equatable {}

class GalleryPageInitiate extends GalleryPageState {
  @override
  List<Object?> get props => [];
}

class GalleryPageLoading extends GalleryPageState {
  @override
  List<Object?> get props => [];
}

class GalleryPageLoaded extends GalleryPageState {
  final List<PixelBayImageModel> list;
  final bool hasReachedEnd;

  GalleryPageLoaded(this.list, {this.hasReachedEnd = false});

  GalleryPageLoaded copyWith({
    List<PixelBayImageModel>? images,
    bool? hasReachedMax,
  }) {
    return GalleryPageLoaded(
      images ?? list,
      hasReachedEnd: hasReachedEnd,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [list, hasReachedEnd];
}


class GalleryPageError extends GalleryPageState {
  final String error;

  GalleryPageError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
