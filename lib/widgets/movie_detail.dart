import 'package:flutter/material.dart';
import 'package:movie_house/models/movie_video_model.dart';
import 'package:movie_house/providers/api.dart';
import 'package:movie_house/screens/play_video_screen.dart';
import 'package:movie_house/widgets/custom_image_provider.dart';
import 'package:movie_house/widgets/my_similar_movies_widget.dart';

import '../models/movie_model.dart';
import 'custom_rating_bar.dart';
import 'custom_text_widget.dart';
import 'loader.dart';
import 'recommended_movies.dart';

showMovieDetail(BuildContext context, MovieModel movieModel) {
  final Size size = MediaQuery.of(context).size;
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              title: movieModel.title ?? movieModel.name!,
              isTitle: true,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 90,
              child: FutureBuilder<List<MovieVideoModel>>(
                future: Api().getMovieVideo(movieModel.id),
                builder: (_, snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    if (snap.hasData) {
                      final List<MovieVideoModel> movies = snap.data!;
                      return movies.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, i) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PlayVideoScreen(
                                        urls: movies,
                                        index: i,
                                        movieId: movieModel.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomImageProvider(
                                        image: movies[i].img!,
                                      ),
                                      Positioned(
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.black45,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              separatorBuilder: (_, i) =>
                                  const SizedBox(width: 12),
                              itemCount: movies.length,
                            )
                          : const Center(
                              child: Text('No video found'),
                            );
                    }
                    return Center(
                      child: Text('Error ${snap.error.toString()}'),
                    );
                  }
                  return const Center(
                    child: Loader(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CustomTextWidget(
                  title: movieModel.releaseDate ?? movieModel.firstAirDate!,
                  date: true,
                ),
                const Spacer(),
                CustomRatingBar(
                  tap: false,
                  initial: movieModel.voteAverage!,
                  onRatingUpdate: (val) {},
                ),
                CustomTextWidget(
                  date: true,
                  title: '(${movieModel.voteCount})',
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextWidget(
              title: movieModel.overview!,
              maxLines: 10,
            ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 45,
              child: TabBar(
                labelStyle: TextStyle(
                  letterSpacing: .5,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Similar Movies'),
                  Tab(text: 'Recommended Movies'),
                ],
              ),
            ),
            Container(
              height: size.height * .4,
              margin: const EdgeInsets.only(top: 8),
              child: TabBarView(
                children: [
                  MySimilarMoviesWidget(id: movieModel.id),
                  MyRecommendedMovies(id: movieModel.id)
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}// similar
