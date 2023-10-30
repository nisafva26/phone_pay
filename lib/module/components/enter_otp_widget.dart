import 'dart:async';
import 'dart:developer';

import 'package:dreampot_phonepay/common/rounded_button.dart';
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EnterOtpWidget extends StatefulWidget {
  const EnterOtpWidget({
    super.key,
    required this.formKey,
    required this.otpController,
    required this.onButtonPressed,
    required this.editCallBack,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController otpController;

  final VoidCallback onButtonPressed;
  final VoidCallback editCallBack;

  @override
  State<EnterOtpWidget> createState() => _EnterOtpWidgetState();
}

class _EnterOtpWidgetState extends State<EnterOtpWidget> {
  int _otpValiditycount = 10;
  late Timer? _resendOtpTimer;

  @override
  void initState() {
    super.initState();
    startOTPTimer();
  }

  void startOTPTimer() {
    setState(() {
      _otpValiditycount = 30;
    });
    const oneSec = Duration(seconds: 1);
    _resendOtpTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_otpValiditycount == 0) {
          stopOTPTimer();
        } else {
          setState(() {
            _otpValiditycount--;
          });
        }
      },
    );
  }

  void stopOTPTimer() {
    setState(() {
      _resendOtpTimer!.cancel();
      _otpValiditycount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter your OTP',
            style: TextStyle(fontWeight: FontWeight.w900, height: 1, fontSize: 20),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'A 4 digit password has been sent to email@gmail.com',
            style: TextStyle(fontWeight: FontWeight.w400, height: 1.2, fontSize: 14),
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              widget.editCallBack();
            },
            child: const Text(
              'change',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  height: 1,
                  fontSize: 14,
                  color: AppColors.lightBlue),
            ),
          ),
          const SizedBox(
            height: 33,
          ),
          Form(
            key: widget.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: widget.otpController,
                  style: const TextStyle(
                    //              height: 1.5,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Field should not be empty";
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
                    labelText: 'OTP',
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
            height: 25,
          ),
          Row(
            children: [
              const Text(
                'Didn’t get the OTP?',
                style: TextStyle(fontWeight: FontWeight.w400, height: 1.2, fontSize: 14),
              ),
              Text(
                _otpValiditycount > 0
                    ? " Resend in ${_otpValiditycount.toString().padLeft(2, '0')} seconds"
                    : " Resend",
                style: TextStyle(fontWeight: FontWeight.w800, height: 1.2, fontSize: 14),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: RoundedButton(
              text: 'Confirm',
              fontSize: 14,
              callback: () {
                if (widget.formKey.currentState!.validate()) {
                  log('valid');
                  widget.onButtonPressed();
                }
              },
              isLoading: false,
            ),
          )
        ],
      ),
    );
  }
}
