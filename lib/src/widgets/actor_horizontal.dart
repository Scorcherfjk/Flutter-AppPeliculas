import 'package:flutter/material.dart';

import 'package:curso_peliculas/src/models/actores_model.dart';

class ActorHorizontal extends StatelessWidget {
  final List<Actor> actores;

  ActorHorizontal({@required this.actores});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        height: _screenSize.width * 0.6,
        padding: EdgeInsets.only(top: 10.0),
        child: PageView.builder(
          controller: _pageController,
          pageSnapping: false,
          // children: _tarjetas(context),
          itemCount: actores.length,
          itemBuilder: (context, i) => _tarjeta(context, actores[i]),
        ));
  }

  Widget _tarjeta(BuildContext context, Actor actor) {
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(actor.getProfileImg()),
                fit: BoxFit.cover,
                height: 160.0,
              )),
          SizedBox(
            height: 5.0,
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: (){
        
      },
    );



  }
  
}
