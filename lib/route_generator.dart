import 'package:dream_game/pages/landing_page/landing_page.dart';
import 'package:dream_game/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    // print('usrRepo' + args.toString());
    print(settings.name.toString());
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute<void>(builder: (_) => SplashPage());

      case '/LandingPage':
        return const LandingPage().route();
      //
      // case '/LoginPage':
      //   return LoginPage.route();
      //
      // case '/SignUpPage':
      //   return SignupPage.route();
      //
      // case '/ForgotPage':
      //   return ForgotPage.route();
      //
      // case '/OTPPage':
      //   return OTPPage.route(routeArguments: args as RouteArguments);
      //
      // case '/HomePage':
      //   return HomePage.route();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute<void>(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
