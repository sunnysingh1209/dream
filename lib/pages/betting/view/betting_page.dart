import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/pages/betting/cubit/betting_cubit.dart';
import 'package:dream_game/pages/betting/view/place_bet_dialog.dart';
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
        child: BlocConsumer<BettingCubit, BettingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: config.AppColors().appbarBackColor(1.0),
              centerTitle: true,
              title: Text(
                'BETTING',
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
              actions: [
                state.bettingModelList
                            ?.any((element) => element.isSelected == true) ==
                        true
                    ? IconButton(
                        onPressed: () {
                          context.read<BettingCubit>().onPureState();
                          showDialog(
                              context: context,
                              builder: (c) {
                                return BlocProvider.value(
                                  value: context.read<BettingCubit>(),
                                  child: PlaceBetDialog(),
                                );
                              });
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ))
                    : Container()
              ],
            ),
            body: Container(
              width: config.AppConfig(context).appWidth(100.0),
              height: config.AppConfig(context).appHeight(100.0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    top: config.AppConfig(context).appHeight(1),
                    bottom: config.AppConfig(context).appHeight(1)),
                child: GridView.builder(
                  itemCount: state.bettingModelList?.length ?? 0,
                  itemBuilder: (context, index) => DialKey(
                    number: state.bettingModelList?[index].number,
                    index: index,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                ),
              ),
            ));
      },
    ));
  }
}

// DialKey widget
class DialKey extends StatelessWidget {
  final int? number;
  final int? index;

  DialKey({
    this.number,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BettingCubit, BettingState>(
      builder: (context, state) {
        return Center(
          child: InkWell(
            onTap: () {
              context.read<BettingCubit>().onNumberSelected(index);
            },
            child: Container(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: null,
                    backgroundColor: config.AppColors().appbarBackColor(1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$number',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: config.FontFamily().medium),
                        ),
                      ],
                    ),
                  ),
                  state.bettingModelList?[index!].isSelected == true
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
