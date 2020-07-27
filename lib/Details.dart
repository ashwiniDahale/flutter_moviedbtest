import 'package:flutter/material.dart';
import 'package:movedbtest/model/Movie.dart';


class Details extends StatelessWidget {
  final String title;

   Movie movieObj;
 Details({Key key, this.title,@required this.movieObj }) : super(key: key);


  @override
  Widget build(BuildContext context) {
   return Scaffold(

         appBar: AppBar(

           title: Text(title),
         ),
    body: SafeArea(
    child: Container(
        padding: EdgeInsets.all(10),

        child:Center(

          child: Column(
            children: <Widget>[
             SizedBox(
               height: MediaQuery.of(context).size.height *0.40,
               width: MediaQuery.of(context).size.width *0.40,
               child: Card(
                 semanticContainer: true,
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 child: Image.network(
                   "https://image.tmdb.org/t/p/w500"+movieObj.poster_path,
                   fit: BoxFit.fill,
                 ),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0),
                 ),
               ),
             ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(movieObj.title,style:Theme.of(context).textTheme.headline),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description",style: Theme.of(context).textTheme.title,),
              ),
                   Text(movieObj.overview),
            ],
          ),
        ),),
    ),
    
    );
  }
}


