import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> elementos;

  CardSwiper({@required this.elementos});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              'https://picsum.photos/250/200/?image=${elementos[index]}',
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: elementos.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
