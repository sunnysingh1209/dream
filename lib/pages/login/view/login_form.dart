import 'package:dream_game/helper/route_arguement.dart';
import 'package:dream_game/pages/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:formz/formz.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  static Route route({RouteArguments? routeArguments}) {
    return MaterialPageRoute<void>(builder: (_) => LoginForm());
  }

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController? mobileNoTextEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
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
                          Text(
                            'Sign in to continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: config.FontFamily().book),
                            textAlign: TextAlign.center,
                          ), SizedBox(
                            height: config.AppConfig(context)
                                .appHeight(1.0),
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
                                    'Mobile No.',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18,
                                        fontWeight: config.FontFamily().medium),
                                  ),
                                  SizedBox(
                                    height: config.AppConfig(context)
                                        .appHeight(1.0),
                                  ),
                                  _MobilePhone(
                                    loginForm: this,
                                  ),
                                  SizedBox(
                                    height: config.AppConfig(context)
                                        .appHeight(3.0),
                                  ),
                                  _LoginButton(
                                    loginForm: this,
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}

class _MobilePhone extends StatefulWidget {
  final _LoginFormState? loginForm;

  const _MobilePhone({Key? key, this.loginForm}) : super(key: key);

  @override
  State<_MobilePhone> createState() => _MobilePhoneState();
}

class _MobilePhoneState extends State<_MobilePhone> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      print('constraibtWidth ${constraint.maxWidth}');
      return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: widget.loginForm!.mobileNoTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            maxLength: 14,
            onChanged: (text) {
              context.read<LoginCubit>().onPhoneNnumberChange(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText:
                  state.phone.invalid ? 'Please enter valid phone no.' : null,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '+91',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: config.FontFamily().medium,
                    ),
                  ),
                ],
              ),
              suffixIcon: Icon(
                Icons.call,
                color: Colors.black,
              ),

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Phone No',
              contentPadding: EdgeInsets.symmetric(
                  horizontal: config.AppConfig(context).appWidth(2),
                  vertical: config.AppConfig(context).appWidth(2)),
              fillColor: config.AppColors().textFieldBackgroundColor(1),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              border: InputBorder.none,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}

class _LoginButton extends StatelessWidget {
  final _LoginFormState? loginForm;

  const _LoginButton({Key? key, this.loginForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
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
              child: Text(
                'SEND OTP',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: config.FontFamily().medium),
              ),
              height: config.AppConfig(context).appHeight(6),
              minWidth: config.AppConfig(context).appWidth(100),
              onPressed: () {
                if (state.status.isValidated) {
                  // context.read<LoginCubit>().doLogin();
                }
              }),
        );
      },
    );
  }
}
