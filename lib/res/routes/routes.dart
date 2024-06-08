

import 'package:flutter/material.dart';
import 'package:world_news/res/routes/routes_name.dart';
import 'package:world_news/view/category%20news/category_news_screen.dart';
import 'package:world_news/view/home_screen/home_screen.dart';
import 'package:world_news/view/news%20details/news_details.dart';
import 'package:world_news/view/splash_screen/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings){
    //final argu= settings.arguments;

    switch(settings.name){
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
        case RouteName.categoryScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const CategoryNewsScreen());
        // case RouteName.newsDetails:
        // return MaterialPageRoute(builder: (BuildContext context) =>  NewsDetails());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child:Text('No Route Defined'),
            ),
          );
        });
    }
  }
}
