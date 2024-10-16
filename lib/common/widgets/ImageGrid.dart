import 'package:flutter/material.dart';
import 'package:pixalbayapp/data/model/PixelBayImageModel.dart';

class ImageGrid extends StatelessWidget {
  final List<PixelBayImageModel> images;
  final bool hasReachedMax;
  final ScrollController scrollController;

  const ImageGrid(
      {super.key, required this.images,
      required this.hasReachedMax,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = (MediaQuery.of(context).size.width ~/ 150).toInt();
    return GridView.builder(
      controller: scrollController,
      itemCount: hasReachedMax ? images.length : images.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount),
      itemBuilder: (context, index) {
        if (index >= images.length) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ImageTile(image: images[index]);
        }
      },
    );
  }
}

class ImageTile extends StatelessWidget {
  final PixelBayImageModel image;

  const ImageTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(image.previewURL ?? " ", fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thumb_up,size: 10,),
                    Text('${image.likes}',style: const TextStyle(fontSize: 10),),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.tv,size: 10,),
                    Text('${image.views}',style: const TextStyle(fontSize: 10),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
