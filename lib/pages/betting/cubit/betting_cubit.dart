import 'package:bloc/bloc.dart';
import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/model/betting_model.dart';
import 'package:dream_game/model/name.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

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

  void onPlaceBet() {
    emit(
      state.copyWith(statusPlaceBet: FormzStatus.submissionInProgress),
    );
    print(
        'Number ${state.bettingModelList?.where((element) => element.isSelected == true).map((v) => v.toJson(int.parse(state.numberField!.value.toString()))).toList()}');

    emit(
      state.copyWith(
          numberField: Name.pure(),
          statusPlaceBet: FormzStatus.submissionSuccess),
    );
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/LandingPage', (route) => false);
  }
}
