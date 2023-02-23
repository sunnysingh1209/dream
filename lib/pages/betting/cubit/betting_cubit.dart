import 'package:bloc/bloc.dart';
import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/model/betting_model.dart';
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

  void onNumberSelected(int? index) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    List<BettingModel>? bettingModelList = [...?state.bettingModelList];
    print('Sunny List ${bettingModelList[index!].number}');
    bettingModelList[index].isSelected =
        bettingModelList[index].isSelected != null &&
                bettingModelList[index].isSelected == true
            ? false
            : true;

    emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        bettingModelList: bettingModelList));
  }
}
