import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:movie_house/models/movie_video_model.dart';
import 'package:movie_house/widgets/custom_image_provider.dart';
import 'package:movie_house/widgets/custom_text_widget.dart';

class PlayVideoScreen extends StatefulWidget {
  final List<MovieVideoModel> urls;
  final String url;
  const PlayVideoScreen({
    super.key,
    required this.urls,
    required this.url,
  });

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late BetterPlayerController betterPlayerController;

  List<BetterPlayerDataSource> createDataSet() {
    List<BetterPlayerDataSource> dataSourceList = [];
    dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      ),
    );
    dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      ),
    );
    dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8",
      ),
    );
    return dataSourceList;
  }

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    );
    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example player"),
      ),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayerPlaylist(
                betterPlayerConfiguration: const BetterPlayerConfiguration(),
                betterPlayerPlaylistConfiguration:
                    const BetterPlayerPlaylistConfiguration(),
                betterPlayerDataSourceList: createDataSet(),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, i) => InkWell(
                onTap: () {
                  log('hello');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CustomImageProvider(image: widget.urls[i].img!),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              title: widget.urls[i].name!,
                              isTitle: true,
                            ),
                            const SizedBox(height: 2),
                            CustomTextWidget(
                              title:
                                  widget.urls[i].publishedAt!.substring(0, 10),
                              date: true,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, i) => const Divider(height: 0),
              itemCount: widget.urls.length,
            )
          ],
        ),
      ),
    );
  }
}
