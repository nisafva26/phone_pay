import 'dart:async';

import 'package:dreampot_phonepay/common/animated_circular_chart.dart';
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TimeComponent extends StatefulWidget {
  const TimeComponent({
    super.key,
    this.timerDone,
    this.quizLimit,
    this.quizStart,
  });

  final VoidCallback? timerDone;
  final int? quizLimit;
  final int? quizStart;

  @override
  State<TimeComponent> createState() => _TimeComponentState();
}

class _TimeComponentState extends State<TimeComponent> {
  Timer? quizTimer;
  int _quizLimit = 0;
  int _quizStart = 0;

  @override
  void initState() {
    super.initState();
    _quizLimit = widget.quizLimit!;
    _quizStart = widget.quizStart!;

    startQuizTimer();
  }

  void startQuizTimer() {
    const oneSec = Duration(milliseconds: 1000);
    quizTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_quizStart >= _quizLimit) {
          setState(() {
            timer.cancel();
            widget.timerDone!();
          });
        } else {
          setState(() {
            _quizStart++;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularChart(
      size: 70,
      percentageValues: _quizStart,
      total: 12,
      isSecond: false,
    );
  }
}
