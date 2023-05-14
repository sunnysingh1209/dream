import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dream_game/model/error_model.dart';
import 'package:dream_game/model/payment_gateway_model.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:formz/formz.dart';
import 'package:http/http.dart';

import '../../../model/name.dart';

part 'transaction_request_state.dart';

class TransactionRequestCubit extends Cubit<TransactionRequestState> {
  TransactionRequestCubit(this._userRepository)
      : super(TransactionRequestState(
            paymentGatewayModel: new PaymentGatewayModel()));

  final UserRepository _userRepository;

  void uploadTransactionRequest(String? imagePath) async {
    Map<String, String> map = {};
    map['transactionid'] = state.transactionID.value;
    map['gatewayName'] = state.paymentMode!;
    map['screenShot'] = imagePath!;
    map['amount'] = state.amount.value;

    Response response =
        await this._userRepository.transactionRequest(data: map);
    if (response.statusCode == 200) {
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

  void doRequest() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress, message: ''));
    Map<String, String> map = {};
    map['transactionid'] = state.transactionID.value;

    Response response = await this
        ._userRepository
        .uploadTransImage(data: map, filePath: state.imagePath.value);
    if (response.statusCode == 200) {
      print('uploadPath ${jsonDecode(response.body)['data']}');
      uploadTransactionRequest(jsonDecode(response.body)['data']);
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

  void onTransactionIDChanged({String? value}) {
    emit(
      state.copyWith(
          transactionID: Name.dirty(value.toString()),
          status: Formz.validate(
              [Name.dirty(value.toString()), state.amount, state.imagePath])),
    );
  }

  void onAmountChanged({String? value}) {
    emit(
      state.copyWith(
          amount: Name.dirty(value.toString()),
          status: Formz.validate([
            Name.dirty(value.toString()),
            state.transactionID,
            state.imagePath
          ])),
    );
  }

  void onPaymentDropDownChanged({String? value}) {
    emit(
      state.copyWith(
          paymentMode: value,
          status: Formz.validate(
              [state.amount, state.transactionID, state.imagePath])),
    );
  }

  void onUploadImageChanged({String? value}) {
    emit(
      state.copyWith(
          imagePath: Name.dirty(value.toString()),
          status: Formz.validate([
            state.amount,
            state.transactionID,
            Name.dirty(value.toString())
          ])),
    );
  }

  void onGetPaymentMethods() async {
    emit(
        state.copyWith(statusPaymentMethods: FormzStatus.submissionInProgress));
    Response response = await this._userRepository.getPaymentGateway();
    if (response.statusCode == 200) {
      emit(state.copyWith(
          statusPaymentMethods: FormzStatus.submissionSuccess,
          paymentGatewayModel:
              PaymentGatewayModel.fromJson(jsonDecode(response.body))));
    } else {
      emit(
        state.copyWith(
            statusPaymentMethods: FormzStatus.submissionFailure,
            message: ErrorModel.fromJson(jsonDecode(response.body))
                .errors
                ?.join('\n')),
      );
    }
    emit(
      state.copyWith(statusPaymentMethods: FormzStatus.pure, message: ''),
    );
  }
}