part of 'transaction_request_cubit.dart';

class TransactionRequestState extends Equatable {
  const TransactionRequestState(
      {this.status = FormzStatus.pure,
      this.message = '',
      this.paymentMode = 'GooglePay',
      this.transactionID = const Name.pure(),
      this.amount = const Name.pure(),
      this.imagePath = const Name.pure(),
      this.paymentGatewayModel});

  final FormzStatus status;
  final String? message;
  final String? paymentMode;
  final PaymentGatewayModel? paymentGatewayModel;
  final Name transactionID;
  final Name amount;
  final Name imagePath;

  TransactionRequestState copyWith({
    FormzStatus? status,
    String? message,
    String? paymentMode,
    Name? transactionID,
    Name? amount,
    Name? imagePath,
    PaymentGatewayModel? paymentGatewayModel,
  }) {
    return TransactionRequestState(
      paymentMode: paymentMode ?? this.paymentMode,
      message: message ?? this.message,
      amount: amount ?? this.amount,
      imagePath: imagePath ?? this.imagePath,
      transactionID: transactionID ?? this.transactionID,
      paymentGatewayModel: paymentGatewayModel ?? this.paymentGatewayModel,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        message!,
        status,
        transactionID,
        amount,
        paymentMode!,
        imagePath,
        paymentGatewayModel!
      ];
}
