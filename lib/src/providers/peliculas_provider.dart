import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:curso_peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey     = 'b7cccf6248b00c03d14abb919c3fa17e';
  String _url        = 'api.themoviedb.org';
  String _language   = 'es-ES';
  String _apiVersion = '/3';


  Future<List<Pelicula>>getEnCines() async{

    final url = Uri.https(_url, '$_apiVersion/movie/now_playing',{
      'api_key':_apiKey,
      'language':_language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;

  }


  
}