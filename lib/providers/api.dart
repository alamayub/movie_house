// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movie_house/models/review_model.dart';

import '../config/constants.dart';
import '../models/genre_model.dart';
import '../models/movie_model.dart';
import '../models/movie_video_model.dart';

class Api {
  // get genre list
  Future<List<GenreModel>> getGenres() async {
    try {
      var url = '$BASE_URL/genre/movie/list?api_key=$API_KEY&language=en-US';
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      final genres = responseData['genres'];
      return genres != null
          ? genres!.map<GenreModel>((e) => GenreModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // get movie by search
  Future<List<MovieModel>> getMoviesBySearch(String search) async {
    try {
      var url =
          '$BASE_URL/search/movie?api_key=$API_KEY&query=$search&language=en-US&page=1&include_adult=true';
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      final movies = responseData['results'];
      return movies != null
          ? movies!.map<MovieModel>((e) => MovieModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // get trending movies
  Future<List<MovieModel>> getTrendingMovies(String mediaType) async {
    // media_type all, movie, tv, person
    // time_window day, week

    try {
      const timeWindow = 'week';
      var url = '$BASE_URL/trending/$mediaType/$timeWindow?api_key=$API_KEY';
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      final movies = responseData['results'];
      return movies != null
          ? movies!.map<MovieModel>((e) => MovieModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // movies recommendation list
  Future<List<MovieModel>> getRecommendedMovies(int id) async {
    try {
      var url =
          '$BASE_URL/movie/$id/recommendations?api_key=$API_KEY&language=en-US&page=1';
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      final movies = responseData['results'];
      return movies != null
          ? movies!.map<MovieModel>((e) => MovieModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // get movies by genre
  Future<List<MovieModel>> getMoviesByGenre(int id) async {
    try {
      var url = '$BASE_URL/discover/movie?api_key=$API_KEY&with_genres=$id';
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      final movies = responseData['results'];
      return movies != null
          ? movies!.map<MovieModel>((e) => MovieModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // get top rated movies
  Future<List<MovieModel>> getSimilarMovies(int id) async {
    try {
      var url =
          '$BASE_URL/movie/$id/similar?api_key=$API_KEY&language=en-US&page=1';
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      // log('genres ${responseData.toString()}');
      final movies = responseData['results'];
      return movies != null
          ? movies!.map<MovieModel>((e) => MovieModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // get latest movies
  Future<List<MovieModel>> getMoviesBy(String type) async {
    try {
      var url = '$BASE_URL/movie/$type?api_key=$API_KEY&language=en-US&page=1';
      if (type == 'latest') {
        url = '$BASE_URL/movie/$type?api_key=$API_KEY&language=en-US';
      }
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      final movies = responseData['results'];
      return movies != null
          ? movies!.map<MovieModel>((e) => MovieModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // get movies videos
  Future<List<MovieVideoModel>> getMovieVideo(int id) async {
    try {
      var url = '$BASE_URL/movie/$id/videos?api_key=$API_KEY&language=en-US';
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      final movies = responseData['results'];
      // https://www.youtube.com/watch?v=UJlMFx6fm60
      return movies != null
          ? movies!
              .map<MovieVideoModel>((e) => MovieVideoModel.fromJson(e))
              .toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // get reviews for movies
  Future<List<ReviewModel>> getMovieReviews(int id) async {
    try {
      var url =
          '$BASE_URL/movie/$id/reviews?api_key=$API_KEY&language=en-US&page=1';
      final response = await http.get(Uri.parse(url));
      if (response.body.isEmpty) return [];
      final responseData = json.decode(response.body);
      final data = responseData['results'];
      log('Reviews $data');
      return data != null
          ? data!.map<ReviewModel>((e) => ReviewModel.fromJson(e)).toList()
          : [];
    } catch (e) {
      rethrow;
    }
  }

  // get individual movie detail
  Future<MovieModel> getSingleMovie(int id) async {
    // https://api.themoviedb.org/3/movie/157336?api_key={api_key}&append_to_response=videos,images
    try {
      var url = '$BASE_URL/movie/$id?api_key=$API_KEY';
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);
      // log('Single ${responseData.toString()}');
      return MovieModel.fromJson(responseData);
    } catch (e) {
      log('Error 176 ${e.toString()}');
      rethrow;
    }
  }
}
