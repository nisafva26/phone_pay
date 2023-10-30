import 'package:dreampot_phonepay/models/payment_method_model.dart';


final List<PaymentMethodModel> globalPaymentMethods = [
  PaymentMethodModel(
      name: 'Credit card',
      icon: 'assets/images/payments/credit.svg',
      type: PaymentType.creditCard),
  PaymentMethodModel(
      name: 'NetBanking',
      icon: 'assets/images/payments/bank.svg',
      type: PaymentType.netBanking),
  PaymentMethodModel(
      name: 'Phone Pe Wallet',
      icon: 'assets/images/payments/phone_pay.svg',
      type: PaymentType.phonePeWallet),
  PaymentMethodModel(
      name: 'UPI Payments',
      icon: 'assets/images/payments/upi.svg',
      type: PaymentType.upi)
];
