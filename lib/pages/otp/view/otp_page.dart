import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/pages/otp/cubit/otp_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream_game/repos/authentication_repository.dart';
import 'package:dream_game/repos/user_repository.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:formz/formz.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  static Route route({RouteArguments? routeArguments}) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider<OtpCubit>(
        create: (BuildContext context) => OtpCubit(
            userRepository: context.read<UserRepository>(),
            authenticationRepository: context.read<AuthenticationRepository>(),
            routeArguments: routeArguments!),
        child: OtpPage(),
      ),
    );
  }

  @override
  State<OtpPage> createState() => _OtpPageWidgetState();
}

class _OtpPageWidgetState extends State<OtpPage> {
  TextEditingController? otpTextEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Error')));
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: config.AppConfig(context).appHeight(100),
                width: config.AppConfig(context).appWidth(100),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: config.AppConfig(context).appHeight(14)),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/img/user.png',
                          fit: BoxFit.contain,
                          height: config.AppConfig(context).appHeight(10),
                          width: config.AppConfig(context).appWidth(40),
                        ),
                        SizedBox(
                          height: config.AppConfig(context).appHeight(32.0),
                        ),
                        Text(
                          'Sign in to continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: config.FontFamily().book),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'We have sent an otp to your mobile number',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: config.FontFamily().book),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: config.AppConfig(context).appHeight(1.0),
                        ),
                        Container(
                          height: config.AppConfig(context).appHeight(24),
                          width: config.AppConfig(context).appWidth(90),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                14,
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(
                                config.AppConfig(context).appWidth(4)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enter Otp.',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18,
                                      fontWeight: config.FontFamily().medium),
                                ),
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(1.0),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Pinput(
                                      separator: SizedBox(width: 10),
                                      defaultPinTheme: PinTheme(
                                        width: config.AppConfig(context)
                                            .appWidth(13),
                                        height: config.AppConfig(context)
                                            .appHeight(6),
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight:
                                                config.FontFamily().medium),
                                        decoration: BoxDecoration(
                                          color: config.AppColors()
                                              .textFieldBackgroundColor(1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      length: 4,
                                      pinputAutovalidateMode:
                                          PinputAutovalidateMode.onSubmit,
                                      showCursor: true,
                                      onChanged: (value) {
                                        context
                                            .read<OtpCubit>()
                                            .onOtpChanged(value);
                                      },
                                      onCompleted: (pin) {},
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      config.AppConfig(context).appHeight(3.0),
                                ),
                                _OtpSubmitButton(
                                  OtpForm: this,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: config.AppConfig(context).appHeight(2),
                        ),
                        Text(
                          'Resend Otp',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: config.FontFamily().book),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    ));
  }
}

class _OtpSubmitButton extends StatelessWidget {
  final _OtpPageWidgetState? OtpForm;

  const _OtpSubmitButton({Key? key, this.OtpForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: state.status.isValidated
                    ? [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor,
                      ]
                    : [
                        Theme.of(context).primaryColorLight,
                        Theme.of(context).primaryColorLight,
                      ],
              )),
          child: MaterialButton(
              child: state.status.isSubmissionInProgress
                  ? const Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'SUBMIT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: config.FontFamily().medium),
                    ),
              height: config.AppConfig(context).appHeight(6),
              minWidth: config.AppConfig(context).appWidth(100),
              onPressed: () {
                if (state.status.isValidated) {
                  context.read<OtpCubit>().onOtpSubmit();
                }
              }),
        );
      },
    );
  }
}
