import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/models.dart';
import 'package:flutter_movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "Buscar pelicula";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context,
              null); // en vez de null se puede retornar lo que se necesite
        },
        icon: const Icon(Icons.arrow_back));
  }

  Widget _emptyWidget() {
    return const Center(
        child: Icon(Icons.movie_creation_outlined,
            color: Colors.black38, size: 130));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResult');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyWidget();
    }

    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _emptyWidget();
        }

        final movies = snapshot.data!;
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movie: movies[index]));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.generatedHeroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.generatedHeroId!,
        child: FadeInImage(
          image: NetworkImage(movie.getFullPosterImage()),
          placeholder: const AssetImage('assets/no-image.jpg'),
          width: 80,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
