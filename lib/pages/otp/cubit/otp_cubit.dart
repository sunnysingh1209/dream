import 'package:bloc/bloc.dart';
import 'package:dream_game/helper/helper.dart';
import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/model/otp.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:http/http.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository,
      required RouteArguments routeArguments})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _routeArguments = routeArguments,
        super(OtpState()) {}

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final RouteArguments _routeArguments;

  void onOtpChanged(String? value) {
    emit(state.copyWith(
        otp: OTP.dirty(value!), status: Formz.validate([OTP.dirty(value)])));
  }

  void onOtpSubmit() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    var map = Map<String, dynamic>();
    map['mobileNo'] = this._routeArguments.mobileNo;
    map['otp'] = state.otp.value;
    Response response = await _authenticationRepository.logIn(data: map);
    print('ResponseSunny' + response.body);
    if (response.statusCode == 200) {
      _userRepository.setCurrentUser(response.body).then((value) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        Helper.showToast('Success');
        _authenticationRepository.controller
            .add(AuthenticationStatus.authenticated);
      });
    }
  }
}
