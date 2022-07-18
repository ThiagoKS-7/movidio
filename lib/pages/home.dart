import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../models/app_config.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  String _api_key = '';
  String _read_token = '';
  List trendingMovies = [];

  loadMovies() async {
    final GetIt getIt = GetIt.instance;
    AppConfig _config = getIt.get<AppConfig>();
    _api_key = _config.API_KEY;
    _read_token = _config.READ_TOKEN;
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(_api_key, _read_token), logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true
    ));
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    setState(() {
      trendingMovies = trendingResult['results'];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMovies();
  }
  @override
  Widget build(BuildContext context) {
    final GetIt getIt = GetIt.instance;
    AppConfig _config = getIt.get<AppConfig>();
    //final List<String> entries = <String>['A', 'B', 'C', 'D'];
    final List<int> colorCodes = <int>[600, 500, 100];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: const Text('MOVIDIO'),
      ),
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top:20),
        child: Column(
          children: <Widget>[
            Text('Trending Movies', style: TextStyle(fontSize: 24, color:Colors.white),),
            Container(
              child: Expanded(
                child: ListView.builder(
                    itemCount: trendingMovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          width: 160,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(image: DecorationImage(
                                  image: NetworkImage(_config.BASE_IMAGE_API_URL+trendingMovies[index]['poster_path'])
                                )),
                              ),
                              Center(child: Text(trendingMovies[index]['title'] != null ? trendingMovies[index]['title'] : 'Loading...', style: TextStyle(fontSize: 16, color: Colors.white),)),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
