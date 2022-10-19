import 'package:flutter/material.dart';

import '../models/genre_model.dart';
import '../models/movie_model.dart';
import '../providers/api.dart';
import '../widgets/loader.dart';
import '../widgets/movie_card.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GenreModel>>(
      future: Api().getGenres(),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.done) {
          if (snap.hasData) {
            final List<GenreModel> genres = snap.data!;
            return genres.isNotEmpty
                ? DefaultTabController(
                    length: genres.length,
                    child: Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 0,
                        bottom: TabBar(
                          isScrollable: true,
                          tabs: genres.map((e) => Tab(text: e.name)).toList(),
                        ),
                      ),
                      body: TabBarView(
                        children: genres
                            .map((e) => SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                                  child: FutureBuilder<List<MovieModel>>(
                                    future: Api().getMoviesByGenre(e.id),
                                    builder: (_, snap) {
                                      if (snap.connectionState ==
                                          ConnectionState.done) {
                                        if (snap.hasData) {
                                          final List<MovieModel> movies =
                                              snap.data!;
                                          return movies.isNotEmpty
                                              ? ListView.separated(
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  itemBuilder: (_, i) =>
                                                      MovieCard(
                                                          movieModel:
                                                              movies[i]),
                                                  separatorBuilder: (_, i) =>
                                                      const SizedBox(
                                                          height: 12),
                                                  itemCount: movies.length,
                                                )
                                              : const Center(
                                                  child: Text('No movie found'),
                                                );
                                        }
                                        return Center(
                                          child: Text(
                                              'Error ${snap.error.toString()}'),
                                        );
                                      }
                                      return const Center(
                                        child: Loader(),
                                      );
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  )
                : const Center(
                    child: Text('No movie found'),
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
    );
  }
}
