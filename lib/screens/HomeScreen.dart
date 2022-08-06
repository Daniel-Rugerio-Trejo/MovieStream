import 'package:flutter/material.dart';
import 'package:moviestream/widgets/action.dart';
import 'package:moviestream/widgets/animation.dart';
import 'package:moviestream/widgets/comedy.dart';
import 'package:moviestream/widgets/documentary.dart';
import 'package:moviestream/widgets/horror.dart';
import 'package:moviestream/widgets/music.dart';
import 'package:moviestream/widgets/romance.dart';
import 'package:moviestream/widgets/scifi.dart';
import 'package:moviestream/widgets/thriller.dart';
import 'package:moviestream/widgets/toprated2.dart';
import 'package:moviestream/widgets/tv2.dart';
import 'package:moviestream/widgets/upcoming.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../data/data.dart';
import '../widgets/toprated.dart';
import '../widgets/trending.dart';
import '../widgets/tv.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List trendingmovies=[];
  List topratedmovies=[];
  List upcomingmovies=[];
  List nowplaying=[];
  List tv = [];
  List tvtop = [];
  List tvrecomendations = [];
  List horror=[];
  List action=[];
  List animation=[];
  List comedy=[];
  List documentary=[];
  List music=[];
  List romance=[];
  List scifi=[];
  List thriller=[];
  final String apiKey = 'c3da7ee03d466435ecae5be5c2b7fb83';
  final readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjM2RhN2VlMDNkNDY2NDM1ZWNhZTViZTVjMmI3ZmI4MyIsInN1YiI6IjYyY2M1MGYwNGI5YmFlMWEzYzFiZTVhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ehdqDTUsuvaVO0sMpqZBSAzSbTJOY17CtWD7FljqK6Y';
  
  @override
  
  void initState(){
    loadmovies();
    super.initState();
  }

  loadmovies() async{
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readaccesstoken), logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true
    ),defaultLanguage: 'es-MX');

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated(); 
    Map upcomingmoviesresult = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    Map nowplayingresult = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    Map tvtopresult = await tmdbWithCustomLogs.v3.tv.getTopRated();
    Map tvrecomendationsresult = await tmdbWithCustomLogs.v3.tv.getAiringToday();
    Map horrorresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '27');
    Map actionresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '28');
    Map animationresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '16');
    Map comedyresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '35');
    Map documentaryresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '99');
    Map musicresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '10402');
    Map romanceresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '10749');
    Map scifiresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '878');
    Map thrillerresult = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: '53');

    setState(() {
      trendingmovies=trendingresult['results'];
      topratedmovies=topratedresult['results'];
      upcomingmovies=upcomingmoviesresult['results'];
      nowplaying=nowplayingresult['results'];
      tv=tvresult['results'];
      tvtop=tvtopresult['results'];
      tvrecomendations=tvrecomendationsresult['results'];
      horror=horrorresult['results'];
      action=actionresult['results'];
      animation=animationresult['results'];
      comedy=comedyresult['results'];
      documentary=documentaryresult['results'];
      music=musicresult['results'];
      romance=romanceresult['results'];
      scifi=scifiresult['results'];
      thriller=thrillerresult['results'];
      
    });
    print(' trendingmovies ');
    print(trendingmovies);
    print(' topratedmovies ');
    print(topratedmovies);
    print(' upcomingmovies ');
    print(upcomingmovies);
    print(' nowplaying ');
    print(nowplaying);
    print(' tv ');
    print(tv);
    print(' tvtop ');
    print(tvtop);
    print(' horror ');
    print(horror);
    print(' end ');
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      appBar: AppBar(
        backgroundColor: Color(0xff333333),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Container(
          height: 40,
          child: Text('MovieStream UTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            height: 40,
            child: Image.asset('assets/neflixPP.jpg'),
          ),
        ],
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView(
              children: [
                Mdocumentary(trending: documentary),
                TV(tv: tv),
                TV2(tv: tvrecomendations),
            TrendingMovies(
              trending: trendingmovies,
            ),TopRatedMovies2(
              trending: topratedmovies,
            ),Mupcoming(trending: upcomingmovies),
            Maction(trending: action),Manimation(trending: animation),
            Mcomedy(trending: comedy),
            
            Mhorror(trending: horror),
            Mmusic(trending: music),
            Mromance(trending: romance),
            Mscifi(trending: scifi),
            Mthriller(trending: thriller),            
              ],
              
            ),
          ),
        ],
      ),
    );
  }
}