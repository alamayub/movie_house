import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/genre_model.dart';
import '../providers/api.dart';
import 'loader.dart';

class GenreWidget extends StatelessWidget {
  const GenreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genre List',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 8),
          FutureBuilder<List<GenreModel>>(
            future: Api().getGenres(),
            builder: (_, snap) {
              if(snap.connectionState == ConnectionState.done) {
                if(snap.hasData) {
                  final List<GenreModel> genres = snap.data!;
                  return genres.isNotEmpty ? StaggeredGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: genres.map((e) => InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        height: 40,
                        child: Text(
                          e.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            letterSpacing: .5,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )).toList(),
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
        ],
      ),
    );
  }
}
