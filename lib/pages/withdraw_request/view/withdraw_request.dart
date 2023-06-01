import 'package:dream_game/pages/withdraw_request/cubit/withdraw_request_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dream_game/helper/app_config.dart' as config;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class WithdrawRequestPage extends StatefulWidget {
  const WithdrawRequestPage({Key? key, required this.parentKey})
      : super(key: key);

  final GlobalKey<ScaffoldState> parentKey;

  @override
  State<WithdrawRequestPage> createState() => _WithdrawRequestPageState();
}

class _WithdrawRequestPageState extends State<WithdrawRequestPage> {
  TextEditingController? amountTextEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<WithdrawRequestCubit, WithdrawRequestState>(
      listener: (context, state) {
        if (state.status!.isSubmissionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.message!}'),
            ),
          );
        } else if (state.status!.isSubmissionSuccess &&
            state.message!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.message!}'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: config.AppColors().appbarBackColor(1.0),
            centerTitle: true,
            title: Text(
              'WITHDRWAL REQUEST',
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
                margin: EdgeInsets.only(
                    bottom: config.AppConfig(context).appHeight(6.0)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: config.AppConfig(context).appHeight(2.0),
                      ),
                      _AmountIDWidget(
                        requestForm: this,
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
                  child: _RequestButton(
                    requestForm: this,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}

class _AmountIDWidget extends StatelessWidget {
  final _WithdrawRequestPageState? requestForm;

  const _AmountIDWidget({Key? key, this.requestForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<WithdrawRequestCubit, WithdrawRequestState>(
          builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: requestForm!.amountTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            maxLength: 100,
            onChanged: (text) {
              context.read<WithdrawRequestCubit>().onAmountChange(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText:
                  state.amount.invalid ? 'Please enter valid amount' : null,

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Enter Amount',
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

class _RequestButton extends StatelessWidget {
  final _WithdrawRequestPageState? requestForm;

  const _RequestButton({Key? key, this.requestForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawRequestCubit, WithdrawRequestState>(
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
                    'REQUEST',
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
                    : context.read<WithdrawRequestCubit>().doWithdrawl();
              }
            }),
      );
    });
  }
}
