import 'package:flutter/material.dart';
import 'package:movie_house/config/confirmation_dialog.dart';
import 'package:movie_house/models/history_model.dart';
import 'package:movie_house/models/movie_model.dart';
import 'package:movie_house/providers/api.dart';
import 'package:movie_house/providers/firestore.dart';
import 'package:movie_house/widgets/custom_image_provider.dart';
import 'package:movie_house/widgets/custom_text_widget.dart';
import 'package:movie_house/widgets/loader.dart';

import '../config/helper.dart';

class WatchHistoryScreen extends StatelessWidget {
  const WatchHistoryScreen({super.key});

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
                      primary: false,
                      itemBuilder: (context, index) => Dismissible(
                        key: UniqueKey(),
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.endToStart) {
                            var res = await showConfirmationDialog(context: context, title: 'Remove');
                            if(res == true) {
                              await FirestoreProvider().updateStatus(key: lists[index].key);
                            }
                          }
                          return null;
                        },
                        background: Container(color: Colors.red),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetRecentMovieWidget(
                                movieId: lists[index].movieId,
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: lists[index].progress / 100,
                                backgroundColor: Colors.grey,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextWidget(
                                    date: true,
                                    fontSize: 10,
                                    title: getDateWithTime(lists[index].updatedAt!),
                                  ),
                                  CustomTextWidget(
                                    fontSize: 10,
                                    title: '${lists[index].progress}%(${getDurationFromString(lists[index].duration)} / ${getDurationFromString(lists[index].total)})',
                                    date: true,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
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
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          if (snap.hasData) {
            final MovieModel movie = snap.data!;
            return Row(
              children: [
                Container(
                  height: 50,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CustomImageProvider(
                    image: movie.posterPath,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        title: movie.title ?? '',
                        isTitle: true,
                      ),
                      const SizedBox(height: 3),
                      CustomTextWidget(
                        title: movie.overview!,
                        maxLines: 2,
                        date: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Text('Error ${snap.error.toString()}');
        }
        return const Center(
          child: Loader(),
        );
      },
    );
  }
}
