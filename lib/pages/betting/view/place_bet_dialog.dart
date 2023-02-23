import 'package:dream_game/pages/betting/cubit/betting_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PlaceBetDialog extends StatelessWidget {
  const PlaceBetDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? placeBetFieldController = TextEditingController();

    return BlocBuilder<BettingCubit, BettingState>(
      builder: (context, state) {
        return Dialog(
          child: Container(
            height: config.AppConfig(context).appHeight(32),
            width: config.AppConfig(context).appWidth(90),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  18,
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total number selected : ${state.bettingModelList?.where((element) => element.isSelected == true).length} ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: config.FontFamily().demi),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Enter an amount for single number it will be multipled by ${state.bettingModelList?.where((element) => element.isSelected == true).length}  ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: config.FontFamily().demi),
                  ),
                ),
                SizedBox(
                  height: config.AppConfig(context).appHeight(2.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.minimize,
                          color: Colors.red,
                        )),
                    Flexible(
                      child: TextFormField(
                        controller: placeBetFieldController,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: config.FontFamily().medium),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        maxLength: 14,
                        onChanged: (text) {
                          context
                              .read<BettingCubit>()
                              .onAmountChanged(value: text);
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          errorText: state.numberField!.invalid
                              ? 'Please enter valid amount'
                              : null,

                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: 16,
                              fontWeight: config.FontFamily().medium),
                          // labelText: 'Mobile Number',
                          hintText: 'Enter amount',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: config.AppConfig(context).appWidth(2),
                              vertical: config.AppConfig(context).appWidth(2)),
                          fillColor:
                              config.AppColors().textFieldBackgroundColor(1),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: InputBorder.none,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                        )),
                  ],
                ),
                SizedBox(
                  height: config.AppConfig(context).appHeight(2.0),
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: state.statusPlaceBet!.isValidated
                            ? [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor,
                              ]
                            : [
                                Theme.of(context).primaryColorLight,
                                Theme.of(context).primaryColorLight,
                              ],
                      )),
                  child: MaterialButton(
                      child: state.statusPlaceBet!.isSubmissionInProgress
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'PLACE BET',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: config.FontFamily().medium),
                            ),
                      height: config.AppConfig(context).appHeight(6),
                      minWidth: config.AppConfig(context).appWidth(70),
                      onPressed: () {
                        if (state.statusPlaceBet!.isValidated) {
                          state.statusPlaceBet!.isSubmissionInProgress
                              ? null
                          : context.read<BettingCubit>().onPlaceBet();
                        }
                      }),
                ),
                SizedBox(
                  height: config.AppConfig(context).appHeight(2.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
