part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.status = FormzStatus.pure, this.userWallet});

  final FormzStatus? status;
  final UserWallet? userWallet;

  HomeState copyWith({FormzStatus? status, UserWallet? userWallet}) {
    return HomeState(
      userWallet: userWallet ?? this.userWallet,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status!, userWallet!];
}
