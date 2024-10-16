import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixalbayapp/common/widgets/ImageGrid.dart';
import 'package:pixalbayapp/screens/GalleryPage/cubit/GalleryPageCubit.dart';
import 'package:pixalbayapp/screens/GalleryPage/cubit/GalleryPageState.dart';

class GalleryPageView extends StatefulWidget {
  const GalleryPageView({super.key});

  @override
  State<GalleryPageView> createState() => _GalleryPageViewState();
}

class _GalleryPageViewState extends State<GalleryPageView> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<GalleryPageCubit>().loadImages();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PixelBay"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                hintText: "Search Images...",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (context.read<GalleryPageCubit>().state
                        is GalleryPageLoaded) {
                      var state = context.read<GalleryPageCubit>().state
                          as GalleryPageLoaded;
                      state.list.clear();
                    }
                    context
                        .read<GalleryPageCubit>()
                        .searchImages(_searchTextController.text);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<GalleryPageCubit, GalleryPageState>(
        builder: (context, state) {
          if (state is GalleryPageLoading && state is! GalleryPageLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GalleryPageError) {
            return Center(child: Text(state.error));
          } else if (state is GalleryPageLoaded) {
            return ImageGrid(
              images: state.list,
              hasReachedMax: state.hasReachedEnd,
              scrollController: _scrollController,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
