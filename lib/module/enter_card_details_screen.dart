import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:dreampot_phonepay/common/rounded_button.dart';
import 'package:dreampot_phonepay/module/components/card_expiry_input_formatter.dart';
import 'package:dreampot_phonepay/module/components/product_header_card.dart';
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class EnterCardDeatailsScreen extends StatefulWidget {
  final VoidCallback onSubmitButtonPressed;
  final VoidCallback onBackButtonPressed;
  EnterCardDeatailsScreen(
      {super.key,
      required this.onSubmitButtonPressed,
      required this.onBackButtonPressed});

  @override
  State<EnterCardDeatailsScreen> createState() => _EnterCardDeatailsScreenState();
}

class _EnterCardDeatailsScreenState extends State<EnterCardDeatailsScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp cardExpiryRegExp = RegExp(r'^\d{0,2}\/\d{0,2}$');

  bool isPayButtonVisible = false;

  bool isPaymentSuccess = false;
  List<int> numbers = [1, 2, 3];
  int currentStep = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isPaymentSuccess == false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.onBackButtonPressed();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: AppColors.lightBlue,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.lightBlue),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Enter your Credit card details',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, height: 1, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: cardNumberController,
                            style: const TextStyle(
                              //              height: 1.5,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000),
                            ),
                            validator: (value) {
                              return value!.isNotEmpty
                                  ? null
                                  : "Field should not be empty";
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'\d')),
                              _CreditCardInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              hintText: '---- ---- ---- ----',
                              hintStyle: const TextStyle(color: AppColors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(color: Color(0xFF6BC3E8)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(color: Color(0xFF777777)),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 32.0,
                                top: 10,
                                bottom: 10,
                                right: 16,
                              ),
                              labelText: 'Credit Card Number',
                              labelStyle: const TextStyle(
                                //              height: 1.5,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black54,
                              ),
                              prefixStyle: const TextStyle(
                                //              height: 1.5,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: expiryController,
                                  style: const TextStyle(
                                    //              height: 1.5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF000000),
                                  ),
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Field should not be empty";
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'\d')),
                                    LengthLimitingTextInputFormatter(5),
                                    CardExpiryInputFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'MM/YY',
                                    hintStyle: const TextStyle(color: AppColors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide:
                                          const BorderSide(color: Color(0xFF6BC3E8)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide:
                                          const BorderSide(color: Color(0xFF777777)),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                      left: 32.0,
                                      top: 10,
                                      bottom: 10,
                                      right: 16,
                                    ),
                                    labelText: 'Expiry date',
                                    labelStyle: const TextStyle(
                                      //              height: 1.5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black54,
                                    ),
                                    prefixStyle: const TextStyle(
                                      //              height: 1.5,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: cvvController,
                                  style: const TextStyle(
                                    //              height: 1.5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF000000),
                                  ),
                                  validator: (value) {
                                    return value!.isNotEmpty
                                        ? null
                                        : "Field should not be empty";
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '***',
                                    hintStyle: const TextStyle(color: AppColors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide:
                                          const BorderSide(color: Color(0xFF6BC3E8)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide:
                                          const BorderSide(color: Color(0xFF777777)),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                      left: 32.0,
                                      top: 10,
                                      bottom: 10,
                                      right: 16,
                                    ),
                                    labelText: 'CVV',
                                    labelStyle: const TextStyle(
                                      //              height: 1.5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black54,
                                    ),
                                    prefixStyle: const TextStyle(
                                      //              height: 1.5,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: nameController,
                            style: const TextStyle(
                              //              height: 1.5,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000),
                            ),
                            onFieldSubmitted: (value) {
                              setState(() {});
                            },
                            validator: (value) {
                              return value!.isNotEmpty
                                  ? null
                                  : "Field should not be empty";
                            },
                            decoration: InputDecoration(
                              // hintText: 'name',
                              // hintStyle: TextStyle(color: AppColors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(color: Color(0xFF6BC3E8)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(color: Color(0xFF777777)),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 32.0,
                                top: 10,
                                bottom: 10,
                                right: 16,
                              ),
                              labelText: 'Name',
                              labelStyle: const TextStyle(
                                //              height: 1.5,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black54,
                              ),
                              prefixStyle: const TextStyle(
                                //              height: 1.5,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (cardNumberController.text.isNotEmpty &&
                        expiryController.text.isNotEmpty &&
                        cvvController.text.isNotEmpty &&
                        nameController.text.isNotEmpty)
                      FadeInUp(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: RoundedButton(
                            text: 'Pay Rs 500',
                            callback: () {
                              if (formKey.currentState!.validate()) {
                                log('valid');
                                setState(() {
                                  isPaymentSuccess = true;
                                });
                                Future.delayed(Duration(seconds: 2)).then((value) {
                                  widget.onSubmitButtonPressed();
                                });
                              }
                            },
                            isLoading: false,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            if (isPaymentSuccess == true)
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 200,
                          width: 200,
                          child: Lottie.asset('assets/images/payments/success_anim.json',
                              fit: BoxFit.cover)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Your payment was successful.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'You will be taken to the quiz in a few seconds',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _CreditCardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String updatedText = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        updatedText += ' '; // Add a space after every 4 digits
      }
      updatedText += text[i];
    }

    return newValue.copyWith(
      text: updatedText,
      selection: TextSelection.collapsed(offset: updatedText.length),
    );
  }
}
//In this example, we use a TextField to capture the credit card number, and we apply a 
//custom formatter (_CreditCardInputFormatter) using the inputFormatters property. 
//The _CreditCardInputFormatter ensures that a space is inserted after every 4 digits as the user types.
// It also allows only numeric input.





