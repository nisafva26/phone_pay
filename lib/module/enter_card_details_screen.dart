import 'dart:developer';

import 'package:dreampot_phonepay/common/rounded_button.dart';
import 'package:dreampot_phonepay/module/components/product_header_card.dart';
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class EnterCardDeatailsScreen extends StatefulWidget {
  const EnterCardDeatailsScreen({super.key});

  @override
  State<EnterCardDeatailsScreen> createState() => _EnterCardDeatailsScreenState();
}

class _EnterCardDeatailsScreenState extends State<EnterCardDeatailsScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPaymentSuccess = false;
  List<int> numbers = [1, 2, 3];
  int currentStep = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/navlogo.png',
          height: 30,
        ),
        actions: [
          SvgPicture.asset('assets/images/payments/cross.svg'),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: ProductHeaderCard(),
            ),
            const Divider(
              height: 2,
              thickness: 1,
              color: AppColors.borderColor,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: EasyStepper(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                activeStep: currentStep,
                activeStepBackgroundColor: AppColors.white,
                finishedStepBackgroundColor: AppColors.lightBlue,
                finishedStepBorderColor: Colors.white,
                finishedStepBorderType: BorderType.normal,
                activeStepBorderType: BorderType.normal,
                activeStepBorderColor: AppColors.lightBlue,
                unreachedStepBorderColor: Colors.grey[200],
                unreachedStepBorderType: BorderType.normal,
                finishedStepTextColor: Colors.black,
                activeStepTextColor: AppColors.lightBlue,
                unreachedStepTextColor: Colors.black54,
                activeStepIconColor: AppColors.lightBlue,

                lineStyle: const LineStyle(
                    lineLength: 70,
                    lineThickness: 3,
                    lineSpace: 4,
                    lineType: LineType.normal,
                    defaultLineColor: AppColors.lightBlue,
                    progress: 0,
                    unreachedLineColor: Color.fromARGB(156, 184, 170, 183)

                    // progressColor: Colors.purple.shade700,
                    ),
                showLoadingAnimation: false,
                borderThickness: 3,
                internalPadding: 20,
                // loadingAnimation: 'assets/loading_circle.json',
                stepRadius: 12,

                steps: [
                  EasyStep(
                    icon: currentStep == 0
                        ? const Icon(
                            CupertinoIcons.circle_filled,
                            color: AppColors.lightBlue,
                            size: 1,
                          )
                        : const Icon(Icons.done),
                    title: 'Authentication',
                    // lineText: 'Add Address Info',
                  ),
                  EasyStep(
                    icon: currentStep == 1
                        ? const Icon(
                            Icons.circle_rounded,
                            color: AppColors.lightBlue,
                            fill: 1,
                            size: 1,
                          )
                        : const Icon(Icons.done),
                    title: 'Payment',
                    // lineText: 'Go To Checkout',
                  ),
                  EasyStep(
                    icon: currentStep == 2
                        ? const Icon(
                            CupertinoIcons.circle_filled,
                            color: AppColors.lightBlue,
                            fill: 1,
                            size: 1,
                          )
                        : const Icon(Icons.done),
                    title: 'Answer a simple quiz',
                    // lineText: 'Choose Payment Method',
                  ),
                ],
                onStepReached: (index) => setState(() => currentStep = index),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (isPaymentSuccess == false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: RoundedButton(
                        text: 'Pay Rs 500',
                        callback: () {
                          if (formKey.currentState!.validate()) {
                            log('valid');
                            setState(() {
                              isPaymentSuccess = true;
                            });
                          }
                        },
                        isLoading: false,
                      ),
                    )
                  ],
                ),
              ),
            if (isPaymentSuccess == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
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
              )
          ],
        ),
      ),
    );
  }
}
