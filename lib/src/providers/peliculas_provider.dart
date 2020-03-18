import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:curso_peliculas/src/models/actores_model.dart';
import 'package:curso_peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = 'b7cccf6248b00c03d14abb919c3fa17e';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _apiVersion = '/3';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '$_apiVersion/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopular() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '$_apiVersion/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '$_popularesPage'});

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getActores(peliculaId) async {
    final url = Uri.https(_url, '$_apiVersion/movie/$peliculaId/credits',
    {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final actores = Actores.fromJsonList(decodedData['cast']);

    return actores.items;

  }

}
