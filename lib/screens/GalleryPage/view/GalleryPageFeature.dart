import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixalbayapp/data/api/impl/PixelBayService.dart';
import 'package:pixalbayapp/data/repositories/ImageRepository.dart';
import 'package:pixalbayapp/screens/GalleryPage/cubit/GalleryPageCubit.dart';

import 'GalleryPageView.dart';

class GalleryPageFeature extends StatelessWidget {
  const GalleryPageFeature({super.key});

  //Here
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryPageCubit(
        ImageRepository(
          PixelBayService(
            apiClient: Dio(),
          ),
        ),
      ),
      child: const GalleryPageView(),
    );
  }
}
