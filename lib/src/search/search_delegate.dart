import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  final peliculasProvider = new PeliculasProvider();

  final peliculas =[
    'Mulán',
    'Ava',
    'Santana',
    'Joker',
    'Mortal',
    'Rogue',
    'Archive',
    '¡Scooby!'
  ];

  final peliculasRecientes = [
    'Joker',
    'Mortal'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: implement buildActions
      return [
        IconButton(icon: Icon(Icons.clear), onPressed: (){ query:''; })
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // TODO: implement buildLeading
      return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), 
        onPressed: () { 
          close(context, null);
         }
        );
    }
  
    @override
    Widget buildResults(BuildContext context ) {
      // TODO: implement buildResults
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context){
    // TODO: implement buildSuggestions

    if (query.isEmpty){
      return Container();
    } else {
      return FutureBuilder(
        future: peliculasProvider.busqueda(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          
          if (snapshot.hasData){
            return ListView(
              children: snapshot.data.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(placeholder: AssetImage('assets/img/no-image.jpg')
                                      , image: NetworkImage(pelicula.getPosterImg())),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.voteAverage.toString()),
                  onTap: (){
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        },
      );
    }




   /*  final listaSugerida = (query.isEmpty) 
                          ? peliculasRecientes
                          : peliculas.where((element) => 
                                            element.toLowerCase().startsWith(query.toLowerCase())
                                            ).toList();


    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context,i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){},
        );
      }
      ); */
  }

}