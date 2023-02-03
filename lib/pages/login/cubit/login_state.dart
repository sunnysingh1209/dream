part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzStatus.pure, this.phone = const Phone.pure()});

  final FormzStatus status;
  final Phone phone;

  LoginState copyWith({
    FormzStatus? status,
    Phone? phone,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, phone];
}
