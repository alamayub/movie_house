import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_house/models/history_model.dart';
import 'package:movie_house/models/movie_model.dart';
import 'package:movie_house/providers/api.dart';
import 'package:movie_house/providers/firestore.dart';
import 'package:movie_house/widgets/custom_text_widget.dart';
import 'package:movie_house/widgets/loader.dart';

import '../config/helper.dart';

class RecentsScreen extends StatelessWidget {
  const RecentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: StreamBuilder<List<HistoryModel>>(
        stream: FirestoreProvider().getHistoryStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final List<HistoryModel> lists = snapshot.data!;
              return lists.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetRecentMovieWidget(
                                movieId: lists[index].movieId,
                              ),
                              const SizedBox(height: 6),
                              LinearProgressIndicator(
                                value: lists[index].progress / 100,
                                backgroundColor: Colors.grey,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextWidget(
                                    title: '${(lists[index].progress)} %',
                                    date: true,
                                  ),
                                  CustomTextWidget(
                                    title:
                                        '${getDurationfromString(lists[index].duration)} / ${getDurationfromString(lists[index].total)}',
                                    date: true,
                                  ),
                        
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0),
                      itemCount: lists.length,
                    )
                  : const Center(
                      child: Text('No recent activity found'),
                    );
            }
            return Center(
              child: Text('Error ${snapshot.error.toString()}'),
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

class GetRecentMovieWidget extends StatelessWidget {
  final int movieId;
  const GetRecentMovieWidget({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel>(
      future: Api().getSingleMovie(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final MovieModel movie = snapshot.data!;
            log('Movie ${movie.toString()}');
            return Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  color: Colors.purple,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        title: movie.name!,
                        isTitle: true,
                      ),
                      const SizedBox(height: 3),
                      CustomTextWidget(
                        title: movie.overview,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Text('Error ${snapshot.error.toString()}');
        }
        return const Center(
          child: Loader(),
        );
      },
    );
  }
}
