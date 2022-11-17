import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    List<SwipeItem> swipeItems = List.filled(20, SwipeItem(content: 'hola'));
    final MatchEngine matchEngine = MatchEngine(swipeItems: swipeItems);
    final size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        child: SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.5, //50% de la pantalla
            child: SwipeCards(
                matchEngine: matchEngine,
                onStackFinished: () {},
                itemBuilder: (_, int index) {
                  return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'details',
                          arguments: 'movie-instance'),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: AssetImage('assets/no-image.jpg'),
                              image: NetworkImage(
                                  'https://via.placeholder.com/300x400'))));
                })));
  }
}
