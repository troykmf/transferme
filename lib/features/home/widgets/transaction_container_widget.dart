import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

class TransactionTypeContainerWidget extends StatelessWidget {
  const TransactionTypeContainerWidget({
    super.key,
    required this.lineChartName,
    required this.name,
    required this.date,
    required this.amount,
    required this.arrowType,
    required this.amountColor,
  });

  final String lineChartName;
  final String name;
  final String date;
  final String amount;
  final String arrowType;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.width(148),
      height: ResponsiveHelper.height(210),
      margin: EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ResponsivePadding(
            left: 10,
            right: 10,
            top: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(arrowType),

                    Text(
                      '+ \$$amount',
                      // '+ \$54.23',
                      style: extraBoldText(17, amountColor, -1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(10),

          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: SvgPicture.asset(
                  lineChartName,
                  // AppSvgs.incomingLineCurve,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 15,
                child: Text(
                  date,
                  // '23 December 2023',
                  style: mediumText(11, AppColor.textLightGreyColor, -1),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: ResponsivePadding(
                    left: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: mediumText(9, AppColor.blackColor, null),
                        ),
                        Gap(3),
                        Text(
                          name,
                          // 'Johnny Bairstow',
                          style: extraBoldText(10, AppColor.blackColor, null),
                        ),
                      ],
                    ),
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
