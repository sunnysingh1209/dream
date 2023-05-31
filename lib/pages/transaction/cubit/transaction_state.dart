part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  const TransactionState(
      {this.status = FormzStatus.pure, this.userTransaction, this.userWallet});

  final FormzStatus? status;
  final UserTransaction? userTransaction;
  final UserWallet? userWallet;

  TransactionState copyWith(
      {FormzStatus? status,
      UserTransaction? userTransaction,
      UserWallet? userWallet}) {
    return TransactionState(
      userTransaction: userTransaction ?? this.userTransaction,
      userWallet: userWallet ?? this.userWallet,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status!, userTransaction!, userWallet!];
}
