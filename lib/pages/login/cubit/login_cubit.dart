import 'package:bloc/bloc.dart';
import 'package:dream_game/model/phone.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

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
}
