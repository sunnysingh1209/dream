part of 'withdraw_request_cubit.dart';

class WithdrawRequestState extends Equatable {
  const WithdrawRequestState(
      {this.status = FormzStatus.pure,
      this.amount = const Name.pure(),
      this.message = ''});

  final FormzStatus status;
  final Name amount;
  final String? message;

  WithdrawRequestState copyWith({
    FormzStatus? status,
    Name? amount,
    String? message,
  }) {
    return WithdrawRequestState(
      amount: amount ?? this.amount,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, amount, message!];
}
