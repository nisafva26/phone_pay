import 'dart:developer';
import 'dart:io';

import 'package:dreampot_phonepay/module/components/card_netbanking_widget.dart';
import 'package:dreampot_phonepay/module/components/product_header_card.dart';
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_upi/get_upi.dart';

class PhonePayScreen extends StatefulWidget {
  const PhonePayScreen({super.key});

  @override
  State<PhonePayScreen> createState() => _PhonePayScreenState();
}

class _PhonePayScreenState extends State<PhonePayScreen> {
  int currentStep = 0;
  bool isAuthenticationDone = true;
  bool isPaymentDone = true;
  bool isQuizDone = true;
  double progress = 0.2;

  List<int> numbers = [1, 2, 3];

  // final List<Step> steps = [
  //   const Step(
  //     title: Text('Authentication'),
  //     state: StepState.indexed,

  //     content: Text('Authentication step content goes here.'),
  //   ),
  //   const Step(
  //     title: Text('Payment'),
  //     state: StepState.indexed,
  //     isActive: false,
  //     content: Text('Payment step content goes here.'),
  //   ),
  //   const Step(
  //     title: Text('Quiz'),
  //     state: StepState.indexed,
  //     isActive: false,
  //     content: Text('Quiz step content goes here.'),
  //   ),
  // ];
  List upiAppsList = [];
  List<UpiObject> upiAppsListAndroid = [];

  List<String> upiAppLogo = [
    'assets/images/payments/paytm.svg',
    'assets/images/payments/gpay.svg',
    'assets/images/payments/bhim.svg',
    'assets/images/payments/bhim.svg',
  ];

  MethodChannel methodChannel = const MethodChannel("get_upi");
  @override
  void initState() {
    super.initState();
    getUpi();
  }

  Future<void> getUpi() async {
    if (Platform.isAndroid) {
      log('android');
      var value = await GetUPI.apps();
      log('value: ${value.data}');
      upiAppsListAndroid = value.data;
    } else if (Platform.isIOS) {
      var valueIos = await GetUPI.iosApps();
      upiAppsList.clear();
      upiAppsList = valueIos;
    }

    setState(() {});

    log('upi apps : ${upiAppsListAndroid}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: ProductHeaderCard(),
            ),
            const Divider(
              height: 2,
              thickness: 1,
              color: AppColors.borderColor,
            ),
            const SizedBox(
              height: 10,
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
                    unreachedLineColor: Color.fromARGB(156, 184, 170, 183)),
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
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferred Payments',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, height: 1, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 90,
                    child: GridView.builder(
                      itemCount: upiAppLogo.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, mainAxisSpacing: 3, crossAxisSpacing: 7),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xffEAECF0)),
                            color: Colors.white,
                            // image: DecorationImage(
                            //     image: NetworkImage(upiAppLogo[index]))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(upiAppLogo[index]),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text(
                    'Other payment methods',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        height: 1,
                        fontSize: 16,
                        fontFamily: 'Avenir'),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const CardsNetbankingWidget()
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //   elevation: 30,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       const SizedBox(
      //         height: 60,
      //         child: Padding(
      //           padding: EdgeInsets.all(8.0),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Row(
      //                 children: [
      //                   Icon(
      //                     Icons.currency_rupee,
      //                     size: 15,
      //                   ),
      //                   Text(
      //                     '3000',
      //                     style: TextStyle(
      //                         color: Colors.black,
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 15),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: 2,
      //               ),
      //               Text(
      //                 'view details',
      //                 style: TextStyle(color: AppColors.black54, fontSize: 10),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         width: 20,
      //       ),
      //       Expanded(
      //         child: SizedBox(
      //           height: 45,
      //           child: ElevatedButton(
      //             onPressed: () {
      //               // Add your button click action here
      //             },
      //             child: const Text(
      //               'Pay Now',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  List<Step> getSteps() {
    bool isStepComplete(int step) {
      // Implement your own criteria here
      // For example, check if all required fields are filled in a form
      if (step == 0) {
        // Check criteria for Step 1

        return isAuthenticationDone;

        // Your validation logic for Step 1;
      } else if (step == 1) {
        return isPaymentDone;
      } else if (step == 2) {
        // Check criteria for Step 3
        return isQuizDone;
      }
      // Handle other steps if needed
      return false; // Default to false if step is not explicitly handled
    }

    StepState getStepState(int step) {
      // Set the StepState based on the completion status
      return isStepComplete(step) ? StepState.complete : StepState.error;
    }

    return <Step>[
      Step(
          state: currentStep == 0 ? StepState.editing : getStepState(0),
          isActive: currentStep >= 0,
          title: const Text(
            'Authentication',
            style: TextStyle(fontSize: 16),
          ),
          content: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          )),
      Step(
          state: currentStep == 1 ? StepState.editing : getStepState(0),
          isActive: currentStep >= 1,
          title: const Text(
            'Payment',
            style: TextStyle(fontSize: 16),
          ),
          content: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          )),
      Step(
          state: currentStep == 2 ? StepState.editing : getStepState(0),
          isActive: currentStep >= 2,
          title: const Text(
            'Answer a simple quiz',
            style: TextStyle(fontSize: 16),
          ),
          content: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          )),
    ];
  }
}
