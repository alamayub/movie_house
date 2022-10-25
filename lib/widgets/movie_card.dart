import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'custom_image_provider.dart';
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
              height: 90,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomImageProvider(
                image: movieModel.posterPath,
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
                        Row(
                          children: [
                            CustomTextWidget(
                              date: true,
                              title: movieModel.voteAverage!.toStringAsFixed(1),
                            ),
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        // CustomTextWidget(
                        //   date: true,
                        //   title: '${movieModel.voteAverage}/${movieModel.voteCount}',
                        // ),
                        // CustomRatingBar(
                        //   tap: false,
                        //   initial: movieModel.voteAverage,
                        //   onRatingUpdate: (val) {},
                        // ),
                      ],
                    ),
                    CustomTextWidget(
                      title: movieModel.overview!,
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
