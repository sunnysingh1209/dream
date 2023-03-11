import 'dart:io';

import 'package:dream_game/helper/common_progress.dart';
import 'package:dream_game/pages/transaction_request/cubit/transaction_request_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dream_game/helper/app_config.dart' as config;
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TransactionRequestPage extends StatefulWidget {
  const TransactionRequestPage({Key? key, required this.parentKey})
      : super(key: key);

  final GlobalKey<ScaffoldState> parentKey;

  @override
  State<TransactionRequestPage> createState() => _TransactionRequestPageState();
}

class _TransactionRequestPageState extends State<TransactionRequestPage> {
  TextEditingController? transactionIDTextEditor = TextEditingController();
  TextEditingController? amountTextEditor = TextEditingController();

  @override
  void initState() {
    context.read<TransactionRequestCubit>().onGetPaymentMethods();
    super.initState();
  }

  /// Get from gallery
  _getFromGallery() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      // imageFile = File(pickedFile.path);
      context
          .read<TransactionRequestCubit>()
          .onUploadImageChanged(value: pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<TransactionRequestCubit, TransactionRequestState>(
      listener: (context, state) {
        if (state.statusPaymentMethods!.isSubmissionFailure ||
            state.status!.isSubmissionFailure) {
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
              'REQUEST',
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
                      Container(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/img/whatsapp.png',
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: config.AppConfig(context).appWidth(2.0),
                            ),
                            Text(
                              '+91 9041913313',
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: config.FontFamily().medium),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(2.0),
                      ),
                      _TransactionIDWidget(
                        requestForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                      _AmountIDWidget(
                        requestForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                      _PaymentDropdownWidget(
                        requestForm: this,
                      ),
                      SizedBox(
                        height: config.AppConfig(context).appHeight(1.0),
                      ),
                      InkWell(
                        onTap: () async {
                          _getFromGallery();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.centerLeft,
                            width: config.AppConfig(context).appWidth(100.0),
                            height: config.AppConfig(context).appHeight(6.0),
                            decoration: BoxDecoration(
                              color: config.AppColors()
                                  .textFieldBackgroundColor(1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                state.imagePath.value != null &&
                                        state.imagePath.value.isNotEmpty
                                    ? Flexible(
                                        child: Text(
                                          '${state.imagePath.value ?? ''}',
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                          maxLines: 1,
                                        ),
                                      )
                                    : Text(
                                        'Upload Image',
                                        style: TextStyle(
                                          color: Theme.of(context).hintColor,
                                        ),
                                        overflow: TextOverflow.clip,
                                        softWrap: true,
                                        maxLines: 1,
                                      ),
                                Icon(Icons.upload),
                              ],
                            )),
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
                  child: _RequestButton(
                    requestForm: this,
                  ),
                ),
              ),
              state.statusPaymentMethods!.isSubmissionInProgress
                  ? CommonProgressWidget()
                  : Container(),
            ],
          ),
        );
      },
    ));
  }
}

class _TransactionIDWidget extends StatelessWidget {
  final _TransactionRequestPageState? requestForm;

  const _TransactionIDWidget({Key? key, this.requestForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<TransactionRequestCubit, TransactionRequestState>(
          builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: TextFormField(
            controller: requestForm!.transactionIDTextEditor,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: config.FontFamily().medium),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            maxLength: 100,
            onChanged: (text) {
              context
                  .read<TransactionRequestCubit>()
                  .onTransactionIDChanged(value: text);
            },
            decoration: InputDecoration(
              counterText: '',
              errorText:
                  state.transactionID.invalid ? 'Please enter valid ID' : null,

              hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              // labelText: 'Mobile Number',
              hintText: 'Enter Transaction ID',
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

class _AmountIDWidget extends StatelessWidget {
  final _TransactionRequestPageState? requestForm;

  const _AmountIDWidget({Key? key, this.requestForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<TransactionRequestCubit, TransactionRequestState>(
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
              context
                  .read<TransactionRequestCubit>()
                  .onAmountChanged(value: text);
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

class _UploadImageWidget extends StatelessWidget {
  final _TransactionRequestPageState? requestForm;

  const _UploadImageWidget({Key? key, this.requestForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocBuilder<TransactionRequestCubit, TransactionRequestState>(
          builder: (context, state) {
        return InkWell(
          onTap: () async {
            final XFile? pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
              maxWidth: 1800,
              maxHeight: 1800,
              imageQuality: 50,
            );
            if (pickedFile != null) {
              File? imageFile = File(pickedFile.path);
              context
                  .read<TransactionRequestCubit>()
                  .onUploadImageChanged(value: imageFile.path);
            }
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            child: TextFormField(
              readOnly: true,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: config.FontFamily().medium),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              maxLength: 1000,
              decoration: InputDecoration(
                counterText: '',
                errorText: state.imagePath.invalid
                    ? 'Please upload valid image'
                    : null,
                hintStyle: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 16,
                    fontWeight: config.FontFamily().medium),
                hintText: 'Upload Image',
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
          ),
        );
      });
    });
  }
}

class _PaymentDropdownWidget extends StatelessWidget {
  _TransactionRequestPageState? requestForm;

  _PaymentDropdownWidget({Key? key, this.requestForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return BlocConsumer<TransactionRequestCubit, TransactionRequestState>(
        listener: (context, state) {},
        buildWhen: (previous, current) =>
            previous.paymentGatewayModel != current.paymentGatewayModel,
        builder: (context, state) {
          return DropdownButtonFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
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
                contentPadding: EdgeInsets.symmetric(
                    horizontal: config.AppConfig(context).appWidth(3.5),
                    vertical: config.AppConfig(context).appWidth(3.5)),
                filled: true,
                fillColor: config.AppColors().textFieldBackgroundColor(1),
              ),
              value: state.paymentMode,
              onChanged: (String? newValue) {
                context
                    .read<TransactionRequestCubit>()
                    .onPaymentDropDownChanged(value: newValue);
              },
              items: state.statusPaymentMethods.isSubmissionSuccess
                  ? state.paymentGatewayModel!.data!.map((item) {
                      return DropdownMenuItem(
                        value: item.toString(),
                        child: Text(item.toString()),
                      );
                    }).toList()
                  : null);
        },
      );
    });
  }
}

class _RequestButton extends StatelessWidget {
  final _TransactionRequestPageState? requestForm;

  const _RequestButton({Key? key, this.requestForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionRequestCubit, TransactionRequestState>(
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
                    : context.read<TransactionRequestCubit>().doRequest();
              }
            }),
      );
    });
  }
}
