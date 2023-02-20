import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/pages/home/cubit/home_cubit.dart';
import 'package:dream_game/pages/home/view/home_page.dart';
import 'package:dream_game/pages/landing_page/landing_page.dart';
import 'package:dream_game/pages/login/view/login_form.dart';
import 'package:dream_game/pages/otp/view/otp_page.dart';
import 'package:dream_game/pages/profile/cubit/profile_cubit.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:dream_game/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    // print('usrRepo' + args.toString());
    print(settings.name.toString());
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute<void>(builder: (_) => SplashPage());

      case '/LoginPage':
        return LoginForm.route();

      case '/OTPPage':
        return OtpPage.route(routeArguments: args as RouteArguments);

      case '/LandingPage':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<HomeCubit>(
                    create: (BuildContext context) => HomeCubit(
                        userRepository: context.read<UserRepository>())
                      ..onGetUserWallet(),
                  ),
                  BlocProvider<ProfileCubit>(
                    create: (BuildContext context) => ProfileCubit(),
                  )
                ], child: LandingPage()));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute<void>(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
