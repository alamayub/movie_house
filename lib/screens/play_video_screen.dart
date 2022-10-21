import 'package:flutter/material.dart';
import 'package:movie_house/models/history_model.dart';
import 'package:movie_house/models/movie_video_model.dart';
import 'package:movie_house/providers/firestore.dart';
import 'package:movie_house/widgets/custom_image_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  final int movieId;
  final List<MovieVideoModel> urls;
  final int index;
  const PlayVideoScreen({
    super.key,
    required this.movieId,
    required this.urls,
    required this.index,
  });

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  late YoutubePlayerController _controller;
  final YoutubePlayerFlags _flags = const YoutubePlayerFlags(
    autoPlay: true,
    mute: true,
  );
  int index = 0;

  @override
  void initState() {
    setState(() => index = widget.index);
    _controller = YoutubePlayerController(
      initialVideoId: widget.urls[index].key!,
      flags: _flags,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // log('Total ${_controller.value.metaData.duration.inSeconds}');
        // log('Metadata ${_controller.value.metaData}');
        // log('Player State ${_controller.value.playerState}');
        // log('Position ${_controller.value.position}');
        final percentage = (_controller.value.position.inSeconds /
                _controller.value.metaData.duration.inSeconds *
                100)
            .truncate();
        final progress = double.parse(percentage.toStringAsFixed(2));
        final HistoryModel history = HistoryModel(
          key: widget.urls[index].key!,
          movieId: widget.movieId,
          duration: _controller.value.position.toString(),
          total: _controller.value.metaData.duration.toString(),
          progress: progress,
        );
        await _firestoreProvider.updateProgress(history: history);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(widget.urls[index].name!),
        ),
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (_, i) => ListTile(
                  onTap: () {
                    setState(() => index = i);
                    _controller.load(widget.urls[i].key!);
                  },
                  leading: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CustomImageProvider(image: widget.urls[i].img!),
                  ),
                  title: Text(
                    widget.urls[i].name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(widget.urls[i].publishedAt!.substring(0, 10)),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 16,
                  ),
                  selected: index == i,
                  selectedTileColor: Colors.grey.shade100,
                  trailing: Icon(index == i ? Icons.stop : Icons.play_arrow),
                ),
                separatorBuilder: (_, i) => const Divider(height: 0),
                itemCount: widget.urls.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
