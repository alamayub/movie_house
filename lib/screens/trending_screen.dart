import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../providers/api.dart';
import '../widgets/loader.dart';
import '../widgets/movie_card.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'TV'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: FutureBuilder<List<MovieModel>>(
                future: Api().getTrendingMovies('movie'),
                builder: (_, snap) {
                  if(snap.connectionState == ConnectionState.done) {
                    if(snap.hasData) {
                      final List<MovieModel> movies = snap.data!;
                      return movies.isNotEmpty ? ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (_, i) => MovieCard(movieModel: movies[i]),
                        separatorBuilder: (_, i) => const SizedBox(height: 12),
                        itemCount: movies.length,
                      ) : const Center(
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
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: FutureBuilder<List<MovieModel>>(
                future: Api().getTrendingMovies('tv'),
                builder: (_, snap) {
                  // getTrendingMovies
                  if(snap.connectionState == ConnectionState.done) {
                    if(snap.hasData) {
                      final List<MovieModel> movies = snap.data!;
                      return movies.isNotEmpty ? ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (_, i) => MovieCard(movieModel: movies[i]),
                        separatorBuilder: (_, i) => const SizedBox(height: 12),
                        itemCount: movies.length,
                      ) : const Center(
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
              ),
            )
          ],
        )
      ),
    );
  }
}
