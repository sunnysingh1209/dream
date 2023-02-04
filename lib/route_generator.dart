import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/pages/login/view/login_form.dart';
import 'package:dream_game/pages/otp/view/otp_page.dart';
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

      //
      case '/LoginPage':
        return LoginForm.route();
      //
      // case '/SignUpPage':
      //   return SignupPage.route();
      //
      // case '/ForgotPage':
      //   return ForgotPage.route();
      //
      case '/OTPPage':
        return OtpPage.route(routeArguments: args as RouteArguments);
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
