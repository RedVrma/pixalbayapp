import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixalbayapp/data/model/PixelBayImageModel.dart';
import 'package:pixalbayapp/data/repositories/ImageRepository.dart';
import 'package:pixalbayapp/screens/GalleryPage/cubit/GalleryPageCubit.dart';
import 'package:pixalbayapp/screens/GalleryPage/cubit/GalleryPageState.dart';

class MockImageRepository extends Mock implements ImageRepository {}

void main() {
  late GalleryPageCubit cubit;
  late ImageRepository mockRepository;

  setUp(() {
    mockRepository = MockImageRepository();
    cubit = GalleryPageCubit(mockRepository);
  });

  List<PixelBayImageModel> generateRandomPixelBayImageList(int count) {
    final List<PixelBayImageModel> images = [];

    for (int i = 0; i < count; i++) {
      final id = i + 1; // Incrementing ID
      final url = 'url+$id'; // Incrementing URL

      images.add(PixelBayImageModel(
        id: id,
        webformatURL: url,
        previewWidth: 1,
        previewHeight: 1,
        webformatWidth: 1,
        webformatHeight: 1,
        imageWidth: 1,
        imageHeight: 1,
        imageSize: 1,
        views: 1,
        downloads: 1,
        likes: 1,
        comments: 1,
        userId: 1,
      ));
    }

    return images;
  }

  group('GalleryPageCubit', () {
    List<PixelBayImageModel> imagesResponse =
        generateRandomPixelBayImageList(2);

    blocTest<GalleryPageCubit, GalleryPageState>(
      'emits [GalleryPageState(isLoading: true), GalleryPageState(images: images, isLoading: false)] when loadImages is called and succeeds',
      build: () {
        when(() => mockRepository.searchImages(any(), any(), any()))
            .thenAnswer((_) async => imagesResponse);
        return cubit;
      },
      act: (cubit) => cubit.loadImages(),
      expect: () => [
        GalleryPageLoading(),
        GalleryPageLoaded(imagesResponse),
      ],
    );

    //Test if the pagination is working.
    blocTest<GalleryPageCubit, GalleryPageState>(
        'emits [GalleryPageState(isLoading: true), GalleryPageState(images: images, isLoading: false)] when loadImages is called and succeeds',
        build: () {
          cubit.emit(GalleryPageLoaded(imagesResponse));

          when(() => mockRepository.searchImages(any(), any(), any()))
              .thenAnswer((_) async => imagesResponse);
          return cubit;
        },
        act: (cubit) => cubit.loadImages(),
        verify: (cubit) {
          final state = cubit.state;
          if (state is GalleryPageLoaded) {
            expect(state.list.length, 4);
          }
        });
  });
}
