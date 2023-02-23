part of 'betting_cubit.dart';

class BettingState extends Equatable {
  const BettingState(
      {this.status = FormzStatus.pure,
      this.statusPlaceBet = FormzStatus.pure,
      this.bettingModelList,
      this.totalAmount = 0,
      this.numberField = const Name.pure()});

  final FormzStatus? status;
  final FormzStatus? statusPlaceBet;
  final List<BettingModel>? bettingModelList;
  final Name? numberField;
  final int totalAmount;

  BettingState copyWith(
      {FormzStatus? status,
      FormzStatus? statusPlaceBet,
      List<BettingModel>? bettingModelList,
      int? totalAmount,
      Name? numberField}) {
    return BettingState(
      bettingModelList: bettingModelList ?? this.bettingModelList,
      numberField: numberField ?? this.numberField,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      statusPlaceBet: statusPlaceBet ?? this.statusPlaceBet,
    );
  }

  @override
  List<Object> get props =>
      [bettingModelList!, status!, numberField!, statusPlaceBet!, totalAmount];
}
