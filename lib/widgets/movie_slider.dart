// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String title;
  final Function onNextPage;

  const MovieSlider(
      {required this.movies,
      required this.title,
      required this.onNextPage,
      Key? key})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (widget.movies.isEmpty) {
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

    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Column(children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            )),
        SizedBox(height: 5),
        Expanded(
          //Expanded toma todo el tamaño disponible
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) =>
                  _MoviePoster(movie: widget.movies[index])),
        )
      ]),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 110,
      height: 200,
      child: Column(children: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: movie),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                width: 130,
                height: 160,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.getFullPosterImage())),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          movie.title,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        )
      ]),
    );
  }
}
