import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dream_game/model/user_transaction.dart';
import 'package:dream_game/model/user_wallet.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../repos/user_repository.dart';

import 'package:http/http.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit(this._userRepository)
      : super(TransactionState(
            userTransaction: new UserTransaction(),
            userWallet: new UserWallet()));

  final UserRepository _userRepository;

  void onGetTransactionUserWallet() async {
    print('WalletModule ');
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Response response = await this._userRepository.userWallet();
    if (response.statusCode == 200) {
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          userWallet: UserWallet.fromJson(jsonDecode(response.body))));
    } else
      emit(state.copyWith(status: FormzStatus.submissionFailure));
  }

  void onGetUserTransaction() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Response response = await this._userRepository.getUserTransaction();
    if (response.statusCode == 200) {
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          userTransaction:
              UserTransaction.fromJson(jsonDecode(response.body))));
    } else
      emit(state.copyWith(status: FormzStatus.submissionFailure));
  }
}