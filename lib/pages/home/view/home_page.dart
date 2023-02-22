import 'package:dream_game/helper/common_progress.dart';
import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/pages/home/cubit/home_cubit.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.parentKey}) : super(key: key);

  final GlobalKey<ScaffoldState> parentKey;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
          body: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Container(
                width: config.AppConfig(context).appWidth(100.0),
                height: config.AppConfig(context).appHeight(100.0),
                child: Stack(
                  children: [
                    Container(
                      width: config.AppConfig(context).appWidth(100.0),
                      height: config.AppConfig(context).appHeight(13.0),
                      color: config.AppColors().appbarBackColor(1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () =>
                                widget.parentKey.currentState!.openDrawer(),
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: Text(
                              'HOME',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: config.FontFamily().demi),
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                widget.parentKey.currentState!.openDrawer(),
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 66.0,
                      left: 14,
                      right: 14,
                      child: Container(
                        width: config.AppConfig(context).appWidth(80.0),
                        height: config.AppConfig(context).appHeight(11.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(
                              12,
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Current Balance',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: config.FontFamily().book),
                              ),
                            ),
                            Text(
                              '\$${state.userWallet?.wallletData?.balance ?? 0.0}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: config.FontFamily().demi),
                            ),
                          ],
                        ),
                      ),
                    ),
                    !state.status!.isSubmissionInProgress
                        ? Positioned(
                            top: 180.0,
                            child: Container(
                              width: config.AppConfig(context).appWidth(100.0),
                              height:
                                  config.AppConfig(context).appHeight(100.0),
                              padding: EdgeInsets.only(
                                  bottom: config.AppConfig(context).appWidth(2),
                                  top: config.AppConfig(context).appWidth(2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: config.AppConfig(context)
                                            .appWidth(2)),
                                    child: Text(
                                      'Game List',
                                      style: TextStyle(
                                          color: config.AppColors()
                                              .homeTitleColor(1.0),
                                          fontSize: 18,
                                          fontWeight:
                                              config.FontFamily().medium),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              navigatorKey.currentState
                                                  ?.pushNamed('/BettingPage',
                                                      arguments: RouteArguments(
                                                          playGameData: state
                                                                  .gamePlayGame
                                                                  ?.playGameData?[
                                                              index]));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  config.AppConfig(context)
                                                      .appWidth(2)),
                                              child: Container(
                                                height:
                                                    config.AppConfig(context)
                                                        .appHeight(12),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                          config.AppConfig(
                                                                  context)
                                                              .appWidth(1.6)),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: const Color(
                                                                  0xff0000001C)
                                                              .withOpacity(
                                                                  0.11),
                                                          blurRadius: 24,
                                                          offset: Offset(0, 25))
                                                    ]),
                                                child: Padding(
                                                    padding: EdgeInsets.all(
                                                        config.AppConfig(
                                                                context)
                                                            .appWidth(3)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '${state.gamePlayGame?.playGameData?[index].gameName}',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 18,
                                                              fontWeight: config
                                                                      .FontFamily()
                                                                  .medium),
                                                        ),
                                                        Spacer(),
                                                        Flexible(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Start Time : ',
                                                                style: TextStyle(
                                                                    color: config
                                                                            .AppColors()
                                                                        .homeTitleColor(
                                                                            1.0),
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        config.FontFamily()
                                                                            .medium),
                                                              ),
                                                              Text(
                                                                '${state.gamePlayGame?.playGameData?[index].startTime}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        config.FontFamily()
                                                                            .demi),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Last Time : ',
                                                                    style: TextStyle(
                                                                        color: config.AppColors().homeTitleColor(
                                                                            1.0),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            config.FontFamily().medium),
                                                                  ),
                                                                  Text(
                                                                    '${state.gamePlayGame?.playGameData?[index].lastTime}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            config.FontFamily().demi),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    'Result Time : ',
                                                                    style: TextStyle(
                                                                        color: config.AppColors().homeTitleColor(
                                                                            1.0),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            config.FontFamily().medium),
                                                                  ),
                                                                  Flexible(
                                                                    child: Text(
                                                                      '${state.gamePlayGame?.playGameData?[index].gameResultTime}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              config.FontFamily().demi),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: config.AppConfig(context)
                                                .appHeight(0.2),
                                          );
                                        },
                                        itemCount: state.gamePlayGame
                                                ?.playGameData?.length ??
                                            0),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),

                    state.status!.isSubmissionInProgress
                        ? CommonProgressWidget()
                        : Container(),

                    // Center(
                    //   child: CupertinoActivityIndicator(
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
