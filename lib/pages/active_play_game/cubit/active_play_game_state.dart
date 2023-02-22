part of 'active_play_game_cubit.dart';

class ActivePlayGameState extends Equatable {
  const ActivePlayGameState({this.status = FormzStatus.pure, this.activePlayGame});

  final FormzStatus? status;
  final ActivePlayGame? activePlayGame;

  ActivePlayGameState copyWith(
      {FormzStatus? status, ActivePlayGame? activePlayGame}) {
    return ActivePlayGameState(
      activePlayGame: activePlayGame ?? this.activePlayGame,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status!, activePlayGame!];
}
