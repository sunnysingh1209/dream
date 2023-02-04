part of 'otp_cubit.dart';

class OtpState extends Equatable {
  const OtpState({this.status = FormzStatus.pure, this.otp = const OTP.pure()});

  final FormzStatus status;
  final OTP otp;

  OtpState copyWith({
    FormzStatus? status,
    OTP? otp,
  }) {
    return OtpState(
      otp: otp ?? this.otp,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [otp, status];
}
