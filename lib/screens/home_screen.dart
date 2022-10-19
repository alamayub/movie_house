import 'package:flutter/material.dart';
import 'package:movie_house/widgets/custom_text_widget.dart';

import '../widgets/movie_list_widget_by.dart';
import '../widgets/trending_widget.dart';
import 'movies_detailed_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // now playing
          SizedBox(height: 16),
          MyHomePageTitleWidget(
            title: 'In Cinemas Now',
            widget: MoviesDetailedListScreen(
              title: 'now_playing',
            ),
          ),
          MoviesListWidgetBy(
            type: 'now_playing',
            isHorizontal: true,
          ),
          SizedBox(height: 20),
          // up coming movies
          MyHomePageTitleWidget(
            title: 'Upcoming Movies',
            widget: MoviesDetailedListScreen(
              title: 'upcoming',
            ),
          ),
          MoviesListWidgetBy(
            type: 'upcoming',
            isHorizontal: true,
          ),
          SizedBox(height: 20),
          // top trending
          MyHomePageTitleWidget(title: 'Trending This Week(Movies / TV)'),
          MyTrendingMoviesWidget(isHorizontal: true),
          SizedBox(height: 20),
          // top rated of all time
          MyHomePageTitleWidget(
            title: 'Top Rated',
            widget: MoviesDetailedListScreen(
              title: 'top_rated',
            ),
          ),
          MoviesListWidgetBy(
            type: 'top_rated',
            isHorizontal: true,
          ),
          SizedBox(height: 20),
          // popular of all time
          MyHomePageTitleWidget(
            title: 'Popular of All Time',
            widget: MoviesDetailedListScreen(
              title: 'popular',
            ),
          ),
          MoviesListWidgetBy(
            type: 'popular',
            isHorizontal: true,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MyHomePageTitleWidget extends StatelessWidget {
  final String title;
  final Widget? widget;
  const MyHomePageTitleWidget({
    super.key,
    required this.title,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                title: title,
                isTitle: true,
              ),
              widget != null
                  ? TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => widget!,
                        ));
                      },
                      icon: const Icon(Icons.arrow_right),
                      label: const Text('More'),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}


/*// latest movies
          const MyHomePageTitleWidget(title: 'Latest'),
          const LatestMoviesWidget(isHorizontal: true),
          const SizedBox(height: 20),

          FutureBuilder<List<MovieModel>>(
            future: Api().getMovies('popular'),
            builder: (_, snap) {
              if (snap.connectionState == ConnectionState.done) {
                if (snap.hasData) {
                  final List<MovieModel> movies = snap.data!;
                  return MoviesListWidget(movies: movies);
                }
                return Center(
                  child: Text('Error ${snap.error.toString()}'),
                );
              }
              return const Center(
                child: Loader(),
              );
            },
          ),*/