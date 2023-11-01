// import 'package:dreampot_phonepay/globals/global_payment_data.dart';
// import 'package:dreampot_phonepay/models/payment_method_model.dart';

// import 'package:dreampot_phonepay/module/enter_card_details_screen.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CardsNetbankingWidget extends StatelessWidget {
//   const CardsNetbankingWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 4,
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         final paymentMethod = globalPaymentMethods[index];
//         return InkWell(
//             onTap: () {
//               if (paymentMethod.type == PaymentType.creditCard) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>  EnterCardDeatailsScreen(onSubmitButtonPressed: (){},onBackButtonPressed: (){},),
//                     ));
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Container(
//              //   height: 64,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color:const Color(0xffEAECF0))),
//                 child: ListTile(
//                 //  dense: true,
//                   leading: SvgPicture.asset(paymentMethod.icon!),
//                   title: Text(
//                     paymentMethod.name!,
//                     style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,color: Color(0xff344054)),
//                   ),
//                 ),
//               ),
//             ));
//       },
//     );
//   }
// }
