import 'package:flutter/material.dart';
import 'package:movie_house/screens/watch_history_screen.dart';

import 'home_screen.dart';
import 'genre_screen.dart';
import 'profile_screen.dart';
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
    WatchHistoryScreen(),
    ProfileScreen(),
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
        onTap: (val) {
          setState(() => _currentIndex = val);
        },
        items: menuLists
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.iconData),
                  label: e.label,
                ))
            .toList(),
      ),
    );
  }
}

class BottomMenu {
  final IconData iconData;
  final String label;
  const BottomMenu({
    required this.iconData,
    required this.label,
  });
}

List<BottomMenu> menuLists = const [
  BottomMenu(iconData: Icons.home_filled, label: 'Home'),
  BottomMenu(iconData: Icons.search, label: 'Search'),
  BottomMenu(iconData: Icons.trending_up, label: 'Trending'),
  BottomMenu(iconData: Icons.category, label: 'Genre'),
  BottomMenu(iconData: Icons.history, label: 'History'),
  BottomMenu(iconData: Icons.person, label: 'Profile'),
];
