import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'genre_screen.dart';
// import 'profile_screen.dart';
import 'search_screen.dart';
import 'trending_screen.dart';

class MovieHouse extends StatefulWidget {
  const MovieHouse({Key? key}) : super(key: key);

  @override
  State<MovieHouse> createState() => _MovieHouseState();
}

class _MovieHouseState extends State<MovieHouse> {
  late final PageController _pageController;
  int _currentIndex = 0;

  static const _pages = [
    HomeScreen(),
    SearchScreen(),
    TrendingScreen(),
    GenreScreen(),
    // ProfileScreen(),
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie House'),
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (val) {
          setState(() => _currentIndex = val);
        },
        children: _pages.map((e) => _pages[_currentIndex]).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (val) {
          setState(() => _currentIndex = val);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Genre',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Profile',
          // ),
        ],
      ),
    );
  }
}
