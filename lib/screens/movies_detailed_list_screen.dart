import 'package:flutter/material.dart';

import '../widgets/movie_list_widget_by.dart';

class MoviesDetailedListScreen extends StatelessWidget {
  final String title;
  const MoviesDetailedListScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: MoviesListWidgetBy(type: 'now_playing'),
      ),
    );
  }
}
