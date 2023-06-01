import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../model/error_model.dart';
import '../../../model/name.dart';

import 'package:http/http.dart';

part 'withdraw_request_state.dart';

class WithdrawRequestCubit extends Cubit<WithdrawRequestState> {
  WithdrawRequestCubit(this._userRepository) : super(WithdrawRequestState());

  UserRepository _userRepository;

  void onAmountChange({String? value}) {
    emit(
      state.copyWith(
          amount: Name.dirty(value.toString()),
          status: Formz.validate([Name.dirty(value.toString())])),
    );
  }

  void doWithdrawl() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    var map = Map<String, dynamic>();
    map['amount'] = state.amount.value;
    Response response = await _userRepository.withdrawlRequest(data: map);
    // print('WithDrawRes ' + jsonDecode(response.body));

    if (response.statusCode == 200) {
      // navigatorKey.currentState!.pushNamed('/OTPPage',
      //     arguments: RouteArguments(mobileNo: state.phone.value));
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          message: jsonDecode(response.body)['data']));
    } else {
      emit(
        state.copyWith(
            status: FormzStatus.submissionFailure,
            message: ErrorModel.fromJson(jsonDecode(response.body))
                .errors
                ?.join('\n')),
      );
    }
    emit(
      state.copyWith(status: FormzStatus.pure, message: ''),
    );
  }
}
