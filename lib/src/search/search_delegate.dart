import 'package:curso_peliculas/src/models/pelicula_model.dart';
import 'package:curso_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  final _peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    // Las acciones del AppBar
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = '';
      }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation 
      ),
      onPressed: (){
        close(context, null);
      });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // Resultados a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // Sugerencias al escribir
    if (query.isEmpty) return Container();

    return  FutureBuilder(
      future: _peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data.map((p){
            return ListTile(
              leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(p.getPosterImg()),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                title: Text(p.title),
                subtitle: Text(p.originalTitle),
                onTap: (){
                  close(context, null);
                  p.uniqueId = '${p.id}-search';
                  Navigator.pushNamed(context, 'detalle', arguments: p);
                },
            );
          }).toList(),
        );
      },
    );
  }

}