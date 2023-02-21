import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dream_game/model/game_play_game.dart';
import 'package:dream_game/model/user_wallet.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required UserRepository userRepository})
      : this._userRepository = userRepository,
        super(HomeState(
            userWallet: new UserWallet(), gamePlayGame: new GamePlayGame())) {}

  final UserRepository _userRepository;

  void onGetUserWallet() async {
    print('WalletModule ');
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Response response = await this._userRepository.userWallet();
    if (response.statusCode == 200) {
      print('WalletModule ${jsonDecode(response.body)}');
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          userWallet: UserWallet.fromJson(jsonDecode(response.body))));
    } else
      emit(state.copyWith(status: FormzStatus.submissionFailure));
  }

  void onGetGamePlayGame() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Response response = await this._userRepository.gamePlayGames();
    if (response.statusCode == 200) {
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          gamePlayGame: GamePlayGame.fromJson(jsonDecode(response.body))));
    } else
      emit(state.copyWith(status: FormzStatus.submissionFailure));
  }
}
