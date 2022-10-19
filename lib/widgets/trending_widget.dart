// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:movie_house/config/constants.dart';
// import 'package:movie_house/widgets/custom_image_provider.dart';

// import '../models/movie_model.dart';
// import '../providers/api.dart';
// import 'loader.dart';

// class MyTrendingMoviesWidget extends StatefulWidget {
//   const MyTrendingMoviesWidget({super.key});

//   @override
//   State<MyTrendingMoviesWidget> createState() => _MyTrendingMoviesWidgetState();
// }

// class _MyTrendingMoviesWidgetState extends State<MyTrendingMoviesWidget> {
//   int current = 0;
//   final CarouselController controller = CarouselController();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<MovieModel>>(
//       future: Api().getTrendingMovies('movie'),
//       builder: (_, snap) {
//         if (snap.connectionState == ConnectionState.done) {
//           if (snap.hasData) {
//             final List<MovieModel> movies = snap.data!;
//             return movies.isNotEmpty
//                 ? Column(
//                     children: [
//                       CarouselSlider(
//                         carouselController: controller,
//                         options: CarouselOptions(
//                           autoPlay: true,
//                           aspectRatio: 16 / 9,
//                           enlargeCenterPage: true,
//                           initialPage: current,
//                           onPageChanged: (index, reason) {
//                             setState(() => current == index);
//                           },
//                         ),
//                         items: movies.map((e) {
//                           return Builder(
//                             builder: (BuildContext context) {
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 clipBehavior: Clip.antiAlias,
//                                 child: CustomImageProvider(
//                                   image: '$IMAGE_URL${e.posterPath}',
//                                 ),
//                               );
//                             },
//                           );
//                         }).toList(),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: movies
//                             .asMap()
//                             .entries
//                             .map(
//                               (e) => GestureDetector(
//                                 onTap: () => controller.animateToPage(e.key),
//                                 child: AnimatedContainer(
//                                   duration: const Duration(microseconds: 500),
//                                   height: 6,
//                                   width: current == e.key ? 20 : 6,
//                                   decoration: BoxDecoration(
//                                     color: current == e.key
//                                         ? Colors.black
//                                         : Colors.black54,
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       )
//                     ],
//                   )
//                 : const Center(
//                     child: Text('No movie found'),
//                   );
//           }
//           return Center(
//             child: Text('Error ${snap.error.toString()}'),
//           );
//         }
//         return const Center(
//           child: Loader(),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../providers/api.dart';
import 'loader.dart';
import 'movies_list_widget.dart';

class MyTrendingMoviesWidget extends StatelessWidget {
  final bool isHorizontal;
  const MyTrendingMoviesWidget({
    super.key,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
      future: Api().getTrendingMovies('all'),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.done) {
          if (snap.hasData) {
            final List<MovieModel> movies = snap.data!;
            return MoviesListWidget(
              movies: movies,
              isHorizontal: isHorizontal,
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
    );
  }
}
