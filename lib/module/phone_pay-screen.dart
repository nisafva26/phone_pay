import 'dart:developer';
import 'dart:io';

import 'package:dreampot_phonepay/common/rounded_button.dart';
import 'package:dreampot_phonepay/globals/global_payment_data.dart';
import 'package:dreampot_phonepay/models/payment_method_model.dart';
import 'package:dreampot_phonepay/module/components/authentication_widget.dart';
import 'package:dreampot_phonepay/module/components/card_netbanking_widget.dart';
import 'package:dreampot_phonepay/module/components/enter_otp_widget.dart';
import 'package:dreampot_phonepay/module/components/product_header_card.dart';
import 'package:dreampot_phonepay/module/components/timer_component.dart';
import 'package:dreampot_phonepay/module/enter_card_details_screen.dart';
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
  PageController pageController = PageController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyOTP = GlobalKey<FormState>();
  int currentStep = 0;
  bool isAuthenticationDone = true;
  bool isPaymentDone = true;
  bool isQuizDone = true;
  double progress = 0.2;
  bool sentOtp = false;
  bool isCardPaymentOption = false;

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
    pageController = PageController(initialPage: currentStep);
    // pageController.addListener(_handlePageChange);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _handleStepChange() {
    setState(() {
      currentStep += 1;
      pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
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

    log('upi apps : $upiAppsListAndroid');
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
        physics: BouncingScrollPhysics(),
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
                enableStepTapping: false,
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
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                children: [
                  // Content for Step 0
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Column(
                      children: [
                        //first showing the authentication screen and then once the otp is sent it shows the otp screen
                        sentOtp == false
                            ? AuthenticationWidget(
                                formKey: formKey,
                                emailController: emailController,
                                mobileController: mobileController,
                                onButtonPressed: () {
                                  log('button pressed');
                                  Future.delayed(const Duration(milliseconds: 300))
                                      .then((value) {
                                    log('after delay');
                                    setState(() {
                                      sentOtp = true;
                                    });
                                  });
                                },
                              )
                            : EnterOtpWidget(
                                formKey: formKeyOTP,
                                otpController: otpController,
                                onButtonPressed: () {
                                  log('button pressed');
                                  Future.delayed(const Duration(milliseconds: 300))
                                      .then((value) {
                                    log('otp verified - going to payment screen');
                                    _handleStepChange();
                                  });
                                },
                                editCallBack: () {
                                  setState(() {
                                    sentOtp = false;
                                  });
                                },
                              ),
                      ],
                    )),
                  ),


                  //step 2
                  isCardPaymentOption == true
                      ? EnterCardDeatailsScreen(
                          onSubmitButtonPressed: () {
                            log('card button tapped');
                            _handleStepChange();
                          },
                          onBackButtonPressed: () {
                            log('back button tapped');
                            setState(() {
                              isCardPaymentOption = false;
                            });
                          },
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Preferred Payments',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, height: 1, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 90,
                                child: GridView.builder(
                                  itemCount: upiAppLogo.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 3,
                                          crossAxisSpacing: 7),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: const Color(0xffEAECF0)),
                                        color: Colors.white,
                                        // image: DecorationImage(
                                        //     image: NetworkImage(upiAppLogo[index]))
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // go to quiz step .
                                          _handleStepChange();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: SvgPicture.asset(upiAppLogo[index]),
                                        ),
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
                              ListView.builder(
                                itemCount: 4,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final paymentMethod = globalPaymentMethods[index];
                                  return InkWell(
                                      onTap: () {
                                        if (paymentMethod.type ==
                                            PaymentType.creditCard) {
                                          setState(() {
                                            isCardPaymentOption = true;
                                          });
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           const EnterCardDeatailsScreen(),
                                          //     ));
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          //   height: 64,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: const Color(0xffEAECF0))),
                                          child: ListTile(
                                            //  dense: true,
                                            leading:
                                                SvgPicture.asset(paymentMethod.icon!),
                                            title: Text(
                                              paymentMethod.name!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Color(0xff344054)),
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              )
                            ],
                          ),
                        ),
                  //step 3
                  QuizWidget(upiAppLogo: upiAppLogo),
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
}

class QuizWidget extends StatelessWidget {
  const QuizWidget({
    super.key,
    required this.upiAppLogo,
  });

  final List<String> upiAppLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://static.toiimg.com/thumb/msid-104744672,width-400,resizemode-4/104744672.jpg'),
                          fit: BoxFit.cover)),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 20,
                top: MediaQuery.of(context).size.height / 4.9,
                //left: MediaQuery.of(context).size.width - 60,
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: TimeComponent(
                    key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
                    quizLimit: 100,
                    quizStart: 0,
                    timerDone: () {
                      log('timer done');
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            'Who is this actor?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800, height: 1, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GridView.builder(
              itemCount: upiAppLogo.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 60,
                  crossAxisSpacing: 7),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: const Color(0xffEAECF0)),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      // end of stepper
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                          child: Text(
                        'Option $index',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      )),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
