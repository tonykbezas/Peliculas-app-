import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  
  final peliculasProvider = new PeliculasProvider();

  //const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas tony'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){}
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas(){

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.hasData){
          return  CardSwiper(peliculas: snapshot.data);
        }else{
          return Container(height: 400.0, child: Center(child: CircularProgressIndicator()));
        }

        
      },
    );

    // peliculasProvider.getEnCines();

    // return  CardSwiper(peliculas: [1,2,3,4,5]);
  }


  Widget _footer(context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.only(left:20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1,)
            ),
          SizedBox(height: 5.0,),
          FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

              if (snapshot.hasData){
                return MovieHorizontal(peliculas: snapshot.data,);
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}