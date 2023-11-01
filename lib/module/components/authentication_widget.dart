import 'dart:developer';

import 'package:dreampot_phonepay/common/rounded_button.dart';
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthenticationWidget extends StatelessWidget {
  const AuthenticationWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.mobileController,
    required this.onButtonPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lets authenticate you',
            style: TextStyle(fontWeight: FontWeight.w900, height: 1, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'An OTP will be sent to your mobile number',
            style: TextStyle(fontWeight: FontWeight.w400, height: 1, fontSize: 14),
          ),
          const SizedBox(
            height: 33,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(
                    //              height: 1.5,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Field should not be empty";
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                    labelText: 'Mobile Number',
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
                  height: 33,
                ),
                TextFormField(
                  controller: mobileController,
                  style: const TextStyle(
                    //              height: 1.5,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Field should not be empty";
                  },
                  onFieldSubmitted: (value) {
                    
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
                    labelText: 'Email',
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
            height: 13,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: RoundedButton(
              text: 'Send OTP',
              fontSize: 14,
              callback: () {
                if (formKey.currentState!.validate()) {
                  log('valid');
                  onButtonPressed();
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