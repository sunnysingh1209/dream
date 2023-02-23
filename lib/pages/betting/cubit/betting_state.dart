part of 'betting_cubit.dart';

class BettingState extends Equatable {
  const BettingState({this.status = FormzStatus.pure, this.bettingModelList});

  final FormzStatus? status;
  final List<BettingModel>? bettingModelList;

  BettingState copyWith({FormzStatus? status, List<BettingModel>? bettingModelList}) {
    return BettingState(
      bettingModelList: bettingModelList ?? this.bettingModelList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [bettingModelList!, status!];
}
