import 'package:flutter/material.dart';
import 'package:world_news/res/routes/routes.dart';
import 'package:world_news/res/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    // home: const SplashScreen(),
    initialRoute: RouteName.splashScreen,
    onGenerateRoute: Routes.generateRoutes,
        );
  }
}

//  MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: const SplashScreen(),
//       initialRoute: RouteName.splashScreen,
//       onGenerateRoute: Routes.generateRoutes,
//     );
