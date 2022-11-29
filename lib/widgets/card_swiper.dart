import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({required this.movies, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
          width: double.infinity,
          height: size.height * 0.5,
          child: const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          ));
    }

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

                  movie.generatedHeroId = 'swiper-${movie.id}';

                  return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'details',
                          arguments: movie),
                      child: Hero(
                        tag: movie.generatedHeroId!, //tag must be unique
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                                fit: BoxFit.cover,
                                placeholder:
                                    const AssetImage('assets/no-image.jpg'),
                                image:
                                    NetworkImage(movie.getFullPosterImage()))),
                      ));
                })));
  }
}
