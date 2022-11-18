import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_movie_app/widgets/movie_slider.dart';

import '../models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({required this.movies, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        child: SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.5, //50% de la pantalla
            child: Swiper(
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) {
                  final movie = movies[index];

                  return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'details',
                          arguments: 'movie-instance'),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/no-image.jpg'),
                              image:
                                  NetworkImage(movie.getFullPosterImage()))));
                })));
  }
}
