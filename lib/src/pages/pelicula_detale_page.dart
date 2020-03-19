import 'package:curso_peliculas/src/models/pelicula_model.dart';
import 'package:curso_peliculas/src/providers/peliculas_provider.dart';
import 'package:curso_peliculas/src/widgets/actor_horizontal.dart';
import 'package:flutter/material.dart';

class PeliculaDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _crearPosterTitulo(context, pelicula),
            _crearDescripcion(pelicula),
            _crearActores(pelicula.id),
          ]))
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(pelicula.title, overflow: TextOverflow.ellipsis,),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackdropImg()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _crearPosterTitulo( BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              )
            ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border),
                    Text(pelicula.voteAverage.toString())
                  ],
                )
              ],
            )
            ),
        ],
      ),
    );
  }

  Widget _crearDescripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,),
    );
  }

  Widget _crearActores(int idPelicula) {
    
    final provider = new PeliculasProvider();

    return FutureBuilder(
      future: provider.getActores(idPelicula),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ActorHorizontal( actores: snapshot.data);
        } else {
          return Container(
              height: 200.0,
              child: Center(
                child: CircularProgressIndicator()
              )
            );
        }
      },
    );
  }
}
