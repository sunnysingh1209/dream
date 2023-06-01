import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/pages/active_play_game/cubit/active_play_game_cubit.dart';
import 'package:dream_game/pages/betting/view/betting_page.dart';
import 'package:dream_game/pages/home/cubit/home_cubit.dart';
import 'package:dream_game/pages/home/view/home_page.dart';
import 'package:dream_game/pages/landing_page/landing_page.dart';
import 'package:dream_game/pages/login/view/login_form.dart';
import 'package:dream_game/pages/otp/view/otp_page.dart';
import 'package:dream_game/pages/profile/cubit/profile_cubit.dart';
import 'package:dream_game/pages/transaction/cubit/transaction_cubit.dart';
import 'package:dream_game/pages/transaction_request/cubit/transaction_request_cubit.dart';
import 'package:dream_game/pages/withdraw_request/cubit/withdraw_request_cubit.dart';
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

      case '/BettingPage':
        return BettingPage.route(routeArguments: args as RouteArguments);

      case '/LandingPage':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<HomeCubit>(
                      create: (BuildContext context) => HomeCubit(
                          userRepository: context.read<UserRepository>())),
                  BlocProvider<ProfileCubit>(
                    create: (BuildContext context) => ProfileCubit(
                        userRepository: context.read<UserRepository>()),
                  ),
                  BlocProvider<ActivePlayGameCubit>(
                    create: (BuildContext context) =>
                        ActivePlayGameCubit(context.read<UserRepository>())
                          ..onGetActivePlayGame(),
                  ),
                  BlocProvider<TransactionCubit>(
                    create: (BuildContext context) =>
                        TransactionCubit(context.read<UserRepository>()),
                  ),
                  BlocProvider<WithdrawRequestCubit>(
                    create: (BuildContext context) =>
                        WithdrawRequestCubit(context.read<UserRepository>()),
                  ),
                  BlocProvider<TransactionRequestCubit>(
                      create: (BuildContext context) => TransactionRequestCubit(
                          context.read<UserRepository>()))
                ], child: LandingPage()));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute<void>(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
