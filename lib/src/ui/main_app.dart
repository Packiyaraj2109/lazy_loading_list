import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_loading_list/src/bloc/home/home_bloc.dart';
import 'package:lazy_loading_list/src/data/constants/screen_routes.dart';
import 'package:lazy_loading_list/src/ui/screen/homepage/home_screen.dart';
import 'package:lazy_loading_list/src/ui/screen/signin/signin_screen.dart';
import 'package:lazy_loading_list/src/ui/screen/signup/signup_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenRoutes.SIGNIN,
      onGenerateRoute: generateRoute,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.SIGNIN:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Signin();
          },
        );
        break;
      case ScreenRoutes.SIGNUP:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Signup();
          },
        );
        break;
      case ScreenRoutes.HOMEPAGE:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider(
              create: (BuildContext context) => HomeBloc(),
              child: HomeScreen(),
            );
          },
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Signin();
          },
        );
    }
  }
}
