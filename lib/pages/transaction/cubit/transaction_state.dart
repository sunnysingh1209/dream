part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  const TransactionState(
      {this.status = FormzStatus.pure,
      this.statusWithDrawl = FormzStatus.pure,
      this.userTransaction,
      this.message = '',
      this.userWallet});

  final FormzStatus? status;
  final FormzStatus? statusWithDrawl;
  final UserTransaction? userTransaction;
  final UserWallet? userWallet;
  final String? message;

  TransactionState copyWith(
      {FormzStatus? status,
      FormzStatus? statusWithDrawl,
      UserTransaction? userTransaction,
      String? message,
      UserWallet? userWallet}) {
    return TransactionState(
      userTransaction: userTransaction ?? this.userTransaction,
      userWallet: userWallet ?? this.userWallet,
      message: message ?? this.message,
      statusWithDrawl: statusWithDrawl ?? this.statusWithDrawl,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [status!, statusWithDrawl!, userTransaction!, userWallet!, message!];
}
