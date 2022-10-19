import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../providers/api.dart';
import '../widgets/loader.dart';
import '../widgets/movies_list_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              right: 16,
              left: 16,
            ),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Search...'),
              onChanged: (String val) {
                setState(() => search = val);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: search != null && search!.isNotEmpty
            ? FutureBuilder<List<MovieModel>>(
                future: Api().getMoviesBySearch(search!),
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
              )
            : const Center(
                child: Text('Search movies...'),
              ),
      ),
    );
  }
}
