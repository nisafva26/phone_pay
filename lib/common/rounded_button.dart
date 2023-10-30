


import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final bool? upperCase;
  final bool isLoading;
  final bool? isFilled;
  final bool isDisable;
  final IconData? icon;
  final VoidCallback? callback;

  const RoundedButton({
    this.text,
    this.backgroundColor = AppColors.lightBlue,
    this.textColor,
    this.icon,
    this.fontSize = 17,
    this.upperCase,
    this.isDisable = false,
    this.callback,
    this.isLoading = false,
    this.isFilled = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(18),
      onPressed: () {
        if (!isLoading) {
          callback!();
        }
      },
      disabledColor: Colors.grey,
      color: isDisable ? Colors.grey : backgroundColor,
      highlightColor: backgroundColor,
      elevation: 0,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(color: textColor ?? backgroundColor!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
               text!,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
          ),
       
          if (isLoading)
            SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          else
            Icon(
              icon ?? Icons.trip_origin,
              size: 15,
              color: textColor ?? Colors.white,
            ),
        ],
      ),
    );
  }
}
