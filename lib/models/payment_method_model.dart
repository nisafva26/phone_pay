

enum PaymentType { creditCard, netBanking, phonePeWallet, upi }

class PaymentMethodModel {
  final String? name;
  final String? icon;
  final PaymentType? type;

  PaymentMethodModel({this.name, this.icon, this.type});

  
}
