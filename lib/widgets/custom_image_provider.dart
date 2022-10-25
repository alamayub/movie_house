import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';

class CustomImageProvider extends StatelessWidget {
  final String? image;
  const CustomImageProvider({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: image != null ? '$IMAGE_URL$image' : 'https://www.pngall.com/wp-content/uploads/12/Avatar-PNG-HD-Image.png',
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Transform.scale(
            scale: .5,
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
