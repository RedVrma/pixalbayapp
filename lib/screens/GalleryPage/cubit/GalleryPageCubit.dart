import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixalbayapp/data/repositories/ImageRepository.dart';

import 'GalleryPageState.dart';


class GalleryPageCubit extends Cubit<GalleryPageState> {
  final ImageRepository repository;
  int pageNumber = 1;
  int imagesPerPage = 60;
  String query = '';

  GalleryPageCubit(this.repository) : super(GalleryPageInitiate());

  void searchImages(String searchQuery) {
    query = searchQuery;
    pageNumber = 1;
    emit(GalleryPageInitiate());
    loadImages();
  }

  Future<void> loadImages() async {
    if (state is GalleryPageLoading) return;

    try {
      if (state is GalleryPageInitiate) {
        emit(GalleryPageLoading());
        final images =
            await repository.searchImages(query, pageNumber, imagesPerPage);
        emit(GalleryPageLoaded(images));
      } else if (state is GalleryPageLoaded) {
        pageNumber = pageNumber + 1;

        GalleryPageLoaded currentState = state as GalleryPageLoaded;
        final nextImages =
            await repository.searchImages(query, pageNumber, imagesPerPage);

        if (nextImages.isEmpty) {
          emit(GalleryPageLoaded(currentState.list, hasReachedEnd: true));
        } else {
          emit(GalleryPageLoaded(currentState.list + nextImages));
        }
      }
    } catch (e) {
      emit(GalleryPageError('Failed to load images'));
    }
  }
}
