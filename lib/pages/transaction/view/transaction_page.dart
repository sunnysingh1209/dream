import 'package:dream_game/helper/common_progress.dart';
import 'package:dream_game/pages/transaction/cubit/transaction_cubit.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key, required this.parentKey}) : super(key: key);

  final GlobalKey<ScaffoldState> parentKey;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    context.read<TransactionCubit>().onGetUserTransaction();
    context.read<TransactionCubit>().onGetTransactionUserWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state.statusWithDrawl!.isSubmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.message!}'),
              ),
            );
          } else if (state.statusWithDrawl!.isSubmissionSuccess &&
              state.message!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.message!}'),
              ),
            );
          }
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
                          'TRANSACTION',
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
                          '\$${state.userWallet?.wallletData?.totalBalance ?? 0.0}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: config.FontFamily().demi),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 180.0,
                    child: Padding(
                      padding: EdgeInsets.all(
                          config.AppConfig(context).appWidth(2.0)),
                      child: Container(
                        height: config.AppConfig(context).appHeight(10),
                        width: config.AppConfig(context).appWidth(96.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  config.AppConfig(context).appWidth(1.6)),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0xff0000001C)
                                      .withOpacity(0.11),
                                  blurRadius: 24,
                                  offset: Offset(0, 2))
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'WIN',
                                  style: TextStyle(
                                      color: config.AppColors()
                                          .homeTitleColor(1.0),
                                      fontSize: 18,
                                      fontWeight: config.FontFamily().medium),
                                ),
                                Flexible(
                                  child: Text(
                                    '\$${state.userWallet?.wallletData?.winningBalance ?? 0.0}',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                        fontWeight: config.FontFamily().demi),
                                  ),
                                ),
                              ],
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: VerticalDivider(
                                color: config.AppColors().homeTitleColor(0.4),
                                thickness: 1,
                              ),
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'WALLET',
                                  style: TextStyle(
                                      color: config.AppColors()
                                          .homeTitleColor(1.0),
                                      fontSize: 18,
                                      fontWeight: config.FontFamily().medium),
                                ),
                                Flexible(
                                  child: Text(
                                    '\$${state.userWallet?.wallletData?.balance ?? 0.0}',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 24,
                                        fontWeight: config.FontFamily().demi),
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    )),
                !state.status!.isSubmissionInProgress
                    ? Positioned(
                        top: 300.0,
                        bottom: 0,
                        child: Container(
                          width: config.AppConfig(context).appWidth(100.0),
                          height: config.AppConfig(context).appHeight(100.0),
                          padding: EdgeInsets.only(
                              bottom: config.AppConfig(context).appWidth(2),
                              top: config.AppConfig(context).appWidth(2)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        config.AppConfig(context).appWidth(2),
                                    left:
                                        config.AppConfig(context).appWidth(2)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Transaction',
                                      style: TextStyle(
                                          color: config.AppColors()
                                              .homeTitleColor(1.0),
                                          fontSize: 18,
                                          fontWeight:
                                              config.FontFamily().medium),
                                    ),
                                    Text(
                                      'Withdrawl Req : ${state.userWallet?.wallletData?.pendingRequest ?? '0'}',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontWeight:
                                              config.FontFamily().medium),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // navigatorKey.currentState?.pushNamed(
                                          //     '/BettingPage',
                                          //     arguments: RouteArguments(
                                          //         playGameData: state
                                          //             .gamePlayGame
                                          //             ?.playGameData?[index]));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              config.AppConfig(context)
                                                  .appWidth(2)),
                                          child: Container(
                                            height: config.AppConfig(context)
                                                .appHeight(18),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      config.AppConfig(context)
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
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${state.userTransaction?.userTransactionData?[index].description}',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
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
                                                            '${state.userTransaction?.userTransactionData?[index].transactionId}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                              Flexible(
                                                                child: Text(
                                                                  '${DateFormat("dd/MM/yyyy hh:mm").format(DateTime.parse('${state.userTransaction?.userTransactionData?[index].createdDate}'))}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          config.FontFamily()
                                                                              .demi),
                                                                ),
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
                                                              Flexible(
                                                                child: Text(
                                                                  '${state.userTransaction?.userTransactionData?[index].position}${state.userTransaction?.userTransactionData?[index]?.amount}',
                                                                  style: TextStyle(
                                                                      color: state.userTransaction?.userTransactionData?[index].position == '-'
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .green,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          config.FontFamily()
                                                                              .demi),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    state
                                                                .userTransaction
                                                                ?.userTransactionData?[
                                                                    index]
                                                                ?.transactionId ==
                                                            'PENDING'
                                                        ? Expanded(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Cancel Request',
                                                                  style: TextStyle(
                                                                      color: config.AppColors()
                                                                          .homeTitleColor(1.0),
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          config.FontFamily()
                                                                              .demi),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    context
                                                                        .read<
                                                                            TransactionCubit>()
                                                                        .doCancelWithdrwal(state
                                                                            .userTransaction
                                                                            ?.userTransactionData![index]);
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .cancel_outlined,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
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
                                    itemCount: state.userTransaction
                                            ?.userTransactionData?.length ??
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
      ),
    ));
  }
}
