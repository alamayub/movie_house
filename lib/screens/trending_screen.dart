import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_house/widgets/person_card.dart';

import '../models/movie_model.dart';
import '../providers/api.dart';
import '../widgets/loader.dart';
import '../widgets/movie_card.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'TV'),
              Tab(text: 'Person'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TrendingMediaWidget(type: 'movie'),
            TrendingMediaWidget(type: 'tv'),
            TrendingMediaWidget(type: 'person'),
          ],
        )
      ),
    );
  }
}

class TrendingMediaWidget extends StatelessWidget {
  final String type;
  const TrendingMediaWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder<List<MovieModel>>(
        future: Api().getTrendingMovies(type),
        builder: (_, snap) {
          // getTrendingMovies
          if(snap.connectionState == ConnectionState.done) {
            if(snap.hasData) {
              final List<MovieModel> movies = snap.data!;
              return movies.isNotEmpty ? ListView.separated(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, i) => type == 'person' ? PersonCard(movieModel: movies[i]) : MovieCard(movieModel: movies[i]),
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
    );
  }
}

