import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/pages/betting/cubit/betting_cubit.dart';
import 'package:dream_game/pages/home/cubit/home_cubit.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:flutter_bloc/flutter_bloc.dart';

class BettingPage extends StatefulWidget {
  const BettingPage({Key? key}) : super(key: key);

  static Route route({RouteArguments? routeArguments}) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider<BettingCubit>(
        create: (BuildContext context) => BettingCubit(
            userRepository: context.read<UserRepository>(),
            routeArguments: routeArguments!),
        child: BettingPage(),
      ),
    );
  }

  @override
  State<BettingPage> createState() => _BettingPageState();
}

class _BettingPageState extends State<BettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: config.AppColors().appbarBackColor(1.0),
        centerTitle: true,
        title: Text(
          'ACTIVE GAME',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: config.FontFamily().demi),
        ),
        leading: IconButton(
          onPressed: () => navigatorKey.currentState?.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(),
    ));
  }
}
