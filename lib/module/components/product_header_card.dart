import 'package:dreampot_phonepay/common/animated_circular_chart.dart';
import 'package:dreampot_phonepay/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductHeaderCard extends StatelessWidget {
  const ProductHeaderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 63,
            width:59,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage('https://m.media-amazon.com/images/I/619f09kK7tL._AC_UF894,1000_QL80_.jpg')),
                border: Border.all(color: AppColors.borderColor)),
          ),
          const SizedBox(
            width: 15,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'iphone 12 pro max',
                style: TextStyle(fontWeight: FontWeight.w900, height: 1,fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Rs 500 per spot',
                 style: TextStyle(fontWeight: FontWeight.w400, height: 1,fontSize: 14),
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  color: const Color(0xFFFFFFFF),
                  child: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: AnimatedCircularChart(
                      size: 70.0,
                      percentageValues: 10,
                      total: 100,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0,bottom: 3),
                child: Text(
                  "out of 100",
                  maxLines: 1,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}