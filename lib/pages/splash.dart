import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/app_config.dart';
import 'package:movie_app/pages/home.dart';

//SERVICES
import 'package:flutter/services.dart';
import 'package:movie_app/services/http_service.dart';
import 'package:movie_app/services/movie_service.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _setup(context).then((_)=>_navigateToHome());
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);
    getIt.registerSingleton<AppConfig>(
        AppConfig(
          BASE_API_URL: configData['BASE_API_URL'],
          READ_TOKEN: configData['READ_TOKEN'],
          BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
          API_KEY: configData['API_KEY'],
        )
    );
    getIt.registerSingleton<MovieService>(MovieService(),);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 350,
                    height: 350,
                    child: Image.asset('assets/images/logo.png')),
                Text("Bem vindo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
