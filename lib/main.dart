import 'package:flutter/material.dart';
import 'package:movie_house/screens/movie_house.dart';

import 'config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie House',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const MovieHouse(),
    );
  }
}
