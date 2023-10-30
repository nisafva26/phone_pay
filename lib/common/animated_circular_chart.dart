
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnimatedCircularChart extends StatelessWidget {
  final double? size;
  final int? total;
  final int? percentageValues;
  final double? fontSize;
  final double? secondFontSize;
  final String? secondText;
  final bool? isSecond;

  const AnimatedCircularChart({
    this.size,
    this.percentageValues,
    this.total = 100,
    this.fontSize = 16,
    this.secondFontSize = 12,
    this.secondText,
    this.isSecond = true,
  });

  @override
  Widget build(BuildContext context) {
    bool isTotalLess = false;
    if (total! < percentageValues!) {
      isTotalLess = true;
    }
    return CircularPercentIndicator(
      
    
      radius: size! / 3,
      percent: percentageValues! / (isTotalLess ? percentageValues! : total!),
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            percentageValues!.toString(),
            textScaleFactor: 1.0,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
          ),
          if (isSecond!)
            Text(
              'left',
              style: TextStyle(
                height: 1,
                fontSize: secondFontSize,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF333333),
              ),
            )
        ],
      ),
      progressColor: AppColors.primaryFG,
    );
  }
}
