import 'package:get_it/get_it.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../models/app_config.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;
  String _api_key = '';
  String _read_token = '';

  MovieService() {
    AppConfig _config = getIt.get<AppConfig>();
    _api_key = _config.API_KEY;
    _read_token = _config.READ_TOKEN;
  }
  getTrendingMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(_api_key, _read_token), logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true
    ));
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    print(trendingResult);
  }
}