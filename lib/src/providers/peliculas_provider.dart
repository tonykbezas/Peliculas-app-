import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apikey   = 'bc9b63a9f6f1f96edf0d82f61220a8be';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  List<Pelicula> _populares = new List();

  final _popularesStream = StreamController<List<Pelicula>>.broadcast();

  diposeStreams(){
    _popularesStream?.close();
  }

  Future<List<Pelicula>> _procesarData(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language': _language
    });
    return await _procesarData(url);
  }

  Future<List<Pelicula>> getPopulares() async {

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language': _language,
      'page'    : _popularesPage.toString()
    });
    return await _procesarData(url);
  }

}