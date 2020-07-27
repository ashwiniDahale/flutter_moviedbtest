import 'package:flutter/material.dart';
import 'package:movedbtest/model/searchResult.dart';

import 'Details.dart';
import 'model/Api.dart';
import 'model/Movie.dart';
import 'model/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'The Movie DB',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Get Now Playing'),
        routes: <String, WidgetBuilder>{
          '/details': (BuildContext context) => Details(title: 'Details'),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Container movieTile(
        String ImagePath, String Heading, String SubHeading, Movie movieObj1) {
      return Container(
        child: Card(
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // margin: EdgeInsets.only(top:5.0),
          child: Wrap(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Details(title: 'Details', movieObj: movieObj1)),
                  );
                },
                leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500" + ImagePath,
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          Heading,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.clip,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, left: 10.0),
                      child: Text(
                        "Release Date : " + SubHeading,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, left: 10.0),
                      child: Text(
                        "Language : " + movieObj1.original_language,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //    ),
      );
    }

    List<Movie> _searchResult = [];
    List<Movie> _movielist = [];

    onSearchTextChanged(String text) async {
      _searchResult.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      _movielist.forEach((movieObj) {
        if (movieObj.title.contains(text) ||
            movieObj.original_title.contains(text)) _searchResult.add(movieObj);
      });

      setState(() {});
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 18.0, left: 18.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search Here...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
              onChanged: onSearchTextChanged,
            ),
          ),
          Expanded(
              child: _searchResult.length != 0 ||
                      _textController.text.isNotEmpty
                  ? FutureBuilder<SearchResult>(
                      future:
                          Api.getSearchMovies(_textController.text.toString()),
                      builder: (context, snapshot) {

                        // print(snapshot.toString());
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          final resultss = snapshot.data;
                          final result = resultss.results;
                          _searchResult = result;
                          return Container(
                            child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.50,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    padding: EdgeInsets.all(15.0),
                                    child: movieTile(
                                        _searchResult[index].poster_path,
                                        _searchResult[index].title,
                                        _searchResult[index].release_date,
                                        _searchResult[index]),
                                  );
                                },
                                itemCount:
                                    _searchResult.length //movie.length,),

                                ),
                          );
                        }
                      })
                  : FutureBuilder<Result>(
                      future: Api.getMovies(),
                      builder: (context, snapshot) {
                        // print(snapshot.toString());
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          final resultss = snapshot.data;
                          final result = resultss.results;
                          return Container(
                            child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.50,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    padding: EdgeInsets.all(15.0),
                                    child: movieTile(
                                        result[index].poster_path,
                                        result[index].title,
                                        result[index].release_date,
                                        result[index]),
                                  );
                                },
                                itemCount: result.length //movie.length,),

                                ),
                          );
                        }
                      }))
        ])));

    //);
  }
}
