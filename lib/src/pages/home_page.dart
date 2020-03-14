import 'package:flutter/material.dart';

import 'package:curso_peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Peliculas'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){}
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              _SwiperCard(),
            ],
          ),
        ),

      ),
    );
  }

  Widget _SwiperCard() {
    return CardSwiper(elementos: [10,11,12,13,14,15,16,17]);
  }


  
}