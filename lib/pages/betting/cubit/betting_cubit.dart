import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dream_game/helper/helper.dart';
import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/model/betting_model.dart';
import 'package:dream_game/model/error_model.dart';
import 'package:dream_game/model/name.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';

part 'betting_state.dart';

class BettingCubit extends Cubit<BettingState> {
  BettingCubit({UserRepository? userRepository, RouteArguments? routeArguments})
      : this._userRepository = userRepository!,
        this._routeArguments = routeArguments!,
        super(BettingState(bettingModelList: [])) {
    onAddBettingData();
  }

  final UserRepository _userRepository;
  final RouteArguments _routeArguments;

  void onAddBettingData() {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    List<BettingModel>? bettingModelList = [];
    for (int i = 1; i < 100; i++) {
      BettingModel? bettingModel = new BettingModel();
      bettingModel.number = i;
      bettingModel.amount = 0;
      bettingModelList.add(bettingModel);
    }

    emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        bettingModelList: bettingModelList));
  }

  void onPureState() {
    emit(state.copyWith(
      numberField: Name.pure(),
      statusPlaceBet: FormzStatus.pure,
    ));
  }

  void onNumberSelected(int? index) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    List<BettingModel>? bettingModelList = [...?state.bettingModelList];
    print('Sunny List ${bettingModelList[index!].number}');
    bettingModelList[index].isSelected = !bettingModelList[index].isSelected!;

    emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        bettingModelList: bettingModelList));
  }

  void onAmountChanged({String? value}) {
    print(_routeArguments.playGameData?.id);
    emit(state.copyWith(
      numberField: Name.dirty(value!),
      statusPlaceBet: Formz.validate([Name.dirty(value)]),
    ));
  }

  void onIncrement() {
    print('Sunny ${state.numberField!.value}');
    if (state.numberField!.value.trim().isNotEmpty) {
      int number = int.parse(state.numberField!.value.toString());
      number += 1;
      print('Sunny ${number}');
      emit(state.copyWith(
        numberField: Name.dirty(number.toString()),
        statusPlaceBet: Formz.validate([Name.dirty(number.toString())]),
      ));
    }
  }

  void onDecrement() {
    if (state.numberField!.value.trim().isNotEmpty &&
        int.parse(state.numberField!.value.trim().toString()) != 0) {
      int number = int.parse(state.numberField!.value.toString());
      number -= 1;
      emit(state.copyWith(
        numberField: Name.dirty(number.toString()),
        statusPlaceBet: Formz.validate([Name.dirty(number.toString())]),
      ));
    }
  }

  void onPlaceBet() async {
    emit(
      state.copyWith(
          statusPlaceBet: FormzStatus.submissionInProgress, message: ''),
    );

    print(
        'Number ${state.bettingModelList?.where((element) => element.isSelected == true).map((v) => v.toJson(int.parse(state.numberField!.value.toString()))).toList()}');
    var map = Map<String, dynamic>();
    map['gameId'] = this._routeArguments.playGameData!.id;
    map['betModels'] = state.bettingModelList
        ?.where((element) => element.isSelected == true)
        .map((v) => v.toJson(int.parse(state.numberField!.value.toString())))
        .toList();
    Response response = await _userRepository.placeBetApi(data: map);
    if (response.statusCode == 200) {
      emit(
        state.copyWith(
            numberField: Name.pure(),
            message: '',
            statusPlaceBet: FormzStatus.submissionSuccess),
      );
      Helper.showToast('Success');
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/LandingPage', (route) => false);
    } else {
      emit(
        state.copyWith(
            statusPlaceBet: FormzStatus.submissionFailure,
            message: ErrorModel.fromJson(jsonDecode(response.body))
                .errors
                ?.join('\n')),
      );
    }
    emit(
      state.copyWith(statusPlaceBet: FormzStatus.pure, message: ''),
    );
  }
}
