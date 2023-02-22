import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dream_game/model/active_play_game.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../repos/user_repository.dart';

import 'package:http/http.dart';

part 'active_play_game_state.dart';

class ActivePlayGameCubit extends Cubit<ActivePlayGameState> {
  ActivePlayGameCubit(this._userRepository)
      : super(ActivePlayGameState(activePlayGame: new ActivePlayGame()));

  final UserRepository _userRepository;

  void onGetActivePlayGame() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Response response = await this._userRepository.getActivePlayGames();
    if (response.statusCode == 200) {
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          activePlayGame: ActivePlayGame.fromJson(jsonDecode(response.body))));
    } else
      emit(state.copyWith(status: FormzStatus.submissionFailure));
  }
}
