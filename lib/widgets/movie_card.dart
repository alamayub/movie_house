import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../models/movie_model.dart';
import 'custom_image_provider.dart';
import 'custom_rating_bar.dart';
import 'custom_text_widget.dart';
import 'movie_detail.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movieModel;
  const MovieCard({
    Key? key,
    required this.movieModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showMovieDetail(context, movieModel),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomImageProvider(
                image: '$IMAGE_URL${movieModel.posterPath}',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextWidget(
                      title: movieModel.title ?? movieModel.name!,
                      isTitle: true,
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          title: movieModel.releaseDate ??
                              movieModel.firstAirDate!,
                          date: true,
                        ),
                        CustomRatingBar(
                          tap: false,
                          initial: movieModel.voteAverage,
                          onRatingUpdate: (val) {},
                        ),
                      ],
                    ),
                    CustomTextWidget(
                      title: movieModel.overview,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
