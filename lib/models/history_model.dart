import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_house/models/movie_model.dart';

class HistoryModel extends Equatable {
  final String key;
  final int movieId;
  final String duration;
  final String total;
  final double progress;
  final int? createdAt;
  final int? updatedAt;

  const HistoryModel({
    required this.key,
    required this.movieId,
    required this.duration,
    required this.total,
    required this.progress,
    this.createdAt,
    this.updatedAt,
  });

  HistoryModel copyWith({
    String? key,
    double? progress,
    String? duration,
    String? total,
    int? movieId,
    int? createdAt,
    int? updatedAt,
    MovieModel? movie,
  }) {
    return HistoryModel(
      key: key ?? this.key,
      movieId: movieId ?? this.movieId,
      duration: duration ?? this.duration,
      total: total ?? this.total,
      progress: progress ?? this.progress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> newToDocument() {
    return {
      'movieId': movieId,
      'progress': progress,
      'duration': duration,
      'total': total,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'updatedAt': DateTime.now().millisecondsSinceEpoch
    };
  }

  Map<String, dynamic> updateToDocument() {
    return {
      'progress': progress,
      'duration': duration,
      'total': total,
      'updatedAt': DateTime.now().millisecondsSinceEpoch
    };
  }

  factory HistoryModel.fromSnapshot(DocumentSnapshot snap) {
    return HistoryModel(
      key: snap.id,
      movieId: snap['movieId'],
      duration: snap['duration'],
      total: snap['total'],
      progress: snap['progress'],
      createdAt: snap['createdAt'],
      updatedAt: snap['updatedAt'],
    );
  }

  @override
  List<Object?> get props => [
        key,
        movieId,
        progress,
        duration,
        total,
        createdAt,
        updatedAt,
      ];
}
