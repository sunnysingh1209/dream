import 'package:bloc/bloc.dart';
import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/model/phone.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(LoginState()) {}

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  void onPhoneNnumberChange({String? value}) {
    emit(
      state.copyWith(
          phone: Phone.dirty(value.toString()),
          status: Formz.validate([Phone.dirty(value.toString())])),
    );
  }

  void doLogin() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    var map = Map<String, dynamic>();
    map['mobileNo'] = state.phone.value;
    Response response = await _authenticationRepository.sendOtp(data: map);
    if (response.statusCode == 200) {
      navigatorKey.currentState!.pushNamed('/OTPPage',
          arguments: RouteArguments(mobileNo: state.phone.value));
    }
  }
}
