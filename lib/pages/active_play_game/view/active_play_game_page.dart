import 'package:dream_game/helper/common_progress.dart';
import 'package:dream_game/pages/active_play_game/cubit/active_play_game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:formz/formz.dart';

class ActivePlayGamePage extends StatefulWidget {
  const ActivePlayGamePage({Key? key, required this.parentKey})
      : super(key: key);

  final GlobalKey<ScaffoldState> parentKey;

  @override
  State<ActivePlayGamePage> createState() => _ActivePlayGamePageState();
}

class _ActivePlayGamePageState extends State<ActivePlayGamePage> {
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
              onPressed: () => widget.parentKey.currentState!.openDrawer(),
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => widget.parentKey.currentState!.openDrawer(),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: BlocConsumer<ActivePlayGameCubit, ActivePlayGameState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Container(
                width: config.AppConfig(context).appWidth(100.0),
                height: config.AppConfig(context).appHeight(100.0),
                child: Stack(
                  children: [
                    !state.status!.isSubmissionInProgress
                        ? Positioned(
                            top: 10.0,
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
                                          return Padding(
                                            padding: EdgeInsets.all(
                                                config.AppConfig(context)
                                                    .appWidth(2)),
                                            child: Container(
                                              height: config.AppConfig(context)
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
                                                            .withOpacity(0.11),
                                                        blurRadius: 24,
                                                        offset: Offset(0, 25))
                                                  ]),
                                              child: Padding(
                                                  padding: EdgeInsets.all(
                                                      config.AppConfig(context)
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
                                                        '${state.activePlayGame?.data?[index].gameName}',
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
                                                              'Start Date : ',
                                                              style: TextStyle(
                                                                  color: config
                                                                          .AppColors()
                                                                      .homeTitleColor(
                                                                          1.0),
                                                                  fontSize: 16,
                                                                  fontWeight: config
                                                                          .FontFamily()
                                                                      .medium),
                                                            ),
                                                            Text(
                                                              '${state.activePlayGame?.data?[index].date}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
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
                                                                  'Number : ',
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
                                                                  '${state.activePlayGame?.data?[index].gameNumber}',
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
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  'Amount : ',
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
                                                                Flexible(
                                                                  child: Text(
                                                                    '${state.activePlayGame?.data?[index].amount}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
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
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: config.AppConfig(context)
                                                .appHeight(0.2),
                                          );
                                        },
                                        itemCount: state
                                                .activePlayGame?.data?.length ??
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
                  ],
                ),
              );
            },
          )),
    );
  }
}
