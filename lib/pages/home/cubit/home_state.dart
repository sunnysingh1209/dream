part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.status = FormzStatus.pure, this.userWallet, this.gamePlayGame});

  final FormzStatus? status;
  final UserWallet? userWallet;
  final GamePlayGame? gamePlayGame;

  HomeState copyWith(
      {FormzStatus? status,
      UserWallet? userWallet,
      GamePlayGame? gamePlayGame}) {
    return HomeState(
      userWallet: userWallet ?? this.userWallet,
      gamePlayGame: gamePlayGame ?? this.gamePlayGame,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status!, userWallet!, gamePlayGame!];
}
