import 'package:dream_game/pages/profile/cubit/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:formz/formz.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.parentKey}) : super(key: key);

  final GlobalKey<ScaffoldState> parentKey;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? nameTextEditor = TextEditingController();
  TextEditingController? addressTextEditor = TextEditingController();
  TextEditingController? cityTextEditor = TextEditingController();
  TextEditingController? stateTextEditor = TextEditingController();
  TextEditingController? pincodeTextEditor = TextEditingController();
  TextEditingController? dobTextEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: config.AppColors().appbarBackColor(1.0),
            centerTitle: true,
            title: Text(
              'PROFILE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: config.FontFamily().demi),
            ),
            leading: IconButton(
              onPressed: () => widget.parentKey.currentState!.openDrawer(),
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                width: config.AppConfig(context).appWidth(100.0),
                height: config.AppConfig(context).appHeight(100.0),
                padding:
                    EdgeInsets.all(config.AppConfig(context).appWidth(4.0)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _NameWidget(
                        profileForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                      _AddressWidget(
                        profileForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                      _StateWidget(
                        profileForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                      _CityWidget(
                        profileForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                      _PincodeWidget(
                        profileForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                      _DobWidget(
                        profileForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      EdgeInsets.all(config.AppConfig(context).appWidth(4.0)),
                  child: _PrifileButton(
                    profileForm: this,
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class _NameWidget extends StatefulWidget {
  final _ProfilePageState? profileForm;

  const _NameWidget({Key? key, this.profileForm}) : super(key: key);

  @override
  State<_NameWidget> createState() => __NameWidgetState();
}

class __NameWidgetState extends State<_NameWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      print('constraibtWidth ${constraint.maxWidth}');
      return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: widget.profileForm!.nameTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            maxLength: 14,
            onChanged: (text) {
              // context.read<LoginCubit>().onPhoneNnumberChange(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText: state.name.invalid ? 'Please enter valid name' : null,

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Enter Name',
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

class _AddressWidget extends StatelessWidget {
  final _ProfilePageState? profileForm;

  const _AddressWidget({Key? key, this.profileForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: profileForm!.addressTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            maxLength: 14,
            onChanged: (text) {
              // context.read<LoginCubit>().onPhoneNnumberChange(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText:
                  state.address.invalid ? 'Please enter valid address' : null,

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Enter Address',
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

class _StateWidget extends StatelessWidget {
  final _ProfilePageState? profileForm;

  const _StateWidget({Key? key, this.profileForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: profileForm!.stateTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            maxLength: 14,
            onChanged: (text) {
              // context.read<LoginCubit>().onPhoneNnumberChange(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText:
                  state.state.invalid ? 'Please enter valid state' : null,

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Enter State',
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

class _CityWidget extends StatelessWidget {
  final _ProfilePageState? profileForm;

  const _CityWidget({Key? key, this.profileForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: profileForm!.cityTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            maxLength: 14,
            onChanged: (text) {
              // context.read<LoginCubit>().onPhoneNnumberChange(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText: state.city.invalid ? 'Please enter valid city' : null,

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Enter City',
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

class _PincodeWidget extends StatelessWidget {
  final _ProfilePageState? profileForm;

  const _PincodeWidget({Key? key, this.profileForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: profileForm!.pincodeTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            maxLength: 14,
            onChanged: (text) {
              // context.read<LoginCubit>().onPhoneNnumberChange(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText:
                  state.pincode.invalid ? 'Please enter valid pincode' : null,

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Enter Pincode',
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

class _DobWidget extends StatelessWidget {
  final _ProfilePageState? profileForm;

  const _DobWidget({Key? key, this.profileForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: profileForm!.dobTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            maxLength: 14,
            onChanged: (text) {
              // context.read<LoginCubit>().onPhoneNnumberChange(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText: state.dob.invalid ? 'Please enter valid D.O.B' : null,

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Enter D.O.B',
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

class _PrifileButton extends StatelessWidget {
  final _ProfilePageState? profileForm;

  const _PrifileButton({Key? key, this.profileForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
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
                      'UPDATE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: config.FontFamily().medium),
                    ),
              height: config.AppConfig(context).appHeight(6),
              minWidth: config.AppConfig(context).appWidth(100),
              onPressed: () {
                if (state.status.isValidated) {
                  state.status.isSubmissionInProgress
                      ? null
                      : context.read<ProfileCubit>().doUpdate();
                }
              }),
        );
      },
    );
  }
}
