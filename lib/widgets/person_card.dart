import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_house/models/movie_model.dart';
import 'package:movie_house/widgets/custom_text_widget.dart';

import '../config/constants.dart';
import 'custom_image_provider.dart';

class PersonCard extends StatelessWidget {
  final MovieModel movieModel;
  const PersonCard({
    Key? key,
    required this.movieModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Vote average ${movieModel.voteAverage}');
    log('Vote count ${movieModel.voteCount}');
    log('Popularity ${movieModel.popularity}');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: CustomImageProvider(
              image: '$IMAGE_URL${movieModel.profilePath}',
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  isTitle: true,
                  title: movieModel.name!,
                ),
                const SizedBox(height: 4),
                CustomTextWidget(
                  date: true,
                  title: movieModel.knownForDepartment!,
                )
              ],
            ),
          ),
          CustomTextWidget(
            date: true,
            center: true,
            fontSize: 10,
            color: Colors.black,
            title: '${movieModel.popularity?.toStringAsFixed(2)}\n100',
          ),
        ],
      ),
    );
  }
}
