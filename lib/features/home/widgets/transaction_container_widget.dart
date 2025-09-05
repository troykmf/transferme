import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

// class TransactionTypeContainerWidget extends StatelessWidget {
//   const TransactionTypeContainerWidget({
//     super.key,
//     required this.lineChartName,
//     required this.name,
//     required this.date,
//     required this.amount,
//     required this.arrowType,
//     required this.amountColor,
//   });

//   final String lineChartName;
//   final String name;
//   final String date;
//   final String amount;
//   final String arrowType;
//   final Color amountColor;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: ResponsiveHelper.width(148),
//       height: ResponsiveHelper.height(210),
//       margin: EdgeInsets.only(left: 16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           ResponsivePadding(
//             left: 10,
//             right: 10,
//             top: 7,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CircleAvatar(
//                   radius: 15,
//                   backgroundColor: Colors.blue,
//                   child: Icon(Icons.arrow_upward, color: Colors.white),
//                 ),
//                 Gap(10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     SvgPicture.asset(arrowType),

//                     Text(
//                       '+ \$$amount',
//                       // '+ \$54.23',
//                       style: extraBoldText(17, amountColor, -1),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Gap(10),

//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 child: SvgPicture.asset(
//                   lineChartName,
//                   // AppSvgs.incomingLineCurve,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 15,
//                 child: Text(
//                   date,
//                   // '23 December 2023',
//                   style: mediumText(11, AppColor.textLightGreyColor, -1),
//                 ),
//               ),
//               Positioned(
//                 child: SizedBox(
//                   height: 70,
//                   width: 70,
//                   child: ResponsivePadding(
//                     left: 10,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'From',
//                           style: mediumText(9, AppColor.blackColor, null),
//                         ),
//                         Gap(3),
//                         Text(
//                           name,
//                           // 'Johnny Bairstow',
//                           style: extraBoldText(10, AppColor.blackColor, null),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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
    final isMobile = ResponsiveHelper.isMobile;
    return Container(
      width: ResponsiveHelper.width(isMobile ? 148 : 120),
      height: ResponsiveHelper.height(isMobile ? 210 : 140),
      margin: EdgeInsets.only(left: ResponsiveHelper.width(isMobile ? 13 : 8)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.width(isMobile ? 20 : 15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: ResponsiveHelper.width(5),
            offset: Offset(0, ResponsiveHelper.height(2)),
          ),
        ],
      ),
      child: Column(
        children: [
          ResponsivePadding(
            left: ResponsiveHelper.width(isMobile ? 8 : 4),
            right: ResponsiveHelper.width(isMobile ? 6 : 2),
            top: ResponsiveHelper.height(isMobile ? 7 : 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: ResponsiveHelper.size(isMobile ? 15 : 15),
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: ResponsiveHelper.sp(isMobile ? 14 : 14),
                  ),
                ),
                Gap(ResponsiveHelper.width(isMobile ? 10 : 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      arrowType,
                      width: ResponsiveHelper.size(isMobile ? 20 : 25),
                      height: ResponsiveHelper.size(isMobile ? 20 : 25),
                    ),
                    Text(
                      '+ \$$amount',
                      style: extraBoldText(
                        ResponsiveHelper.sp(isMobile ? 17 : 7.5),
                        amountColor,
                        -1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(ResponsiveHelper.height(isMobile ? 10 : 10)),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    ResponsiveHelper.width(isMobile ? 20 : 28),
                  ),
                  bottomRight: Radius.circular(
                    ResponsiveHelper.width(isMobile ? 20 : 28),
                  ),
                ),
                child: SvgPicture.asset(
                  lineChartName,
                  fit: BoxFit.fill,
                  width: ResponsiveHelper.width(isMobile ? 148 : 200),
                  height: ResponsiveHelper.height(isMobile ? 140 : 190),
                ),
              ),
              Positioned(
                bottom: 0,
                left: ResponsiveHelper.width(isMobile ? 15 : 20),
                child: Text(
                  date,
                  style: mediumText(
                    ResponsiveHelper.sp(isMobile ? 11 : 4),
                    AppColor.textLightGreyColor,
                    -1,
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: ResponsiveHelper.height(isMobile ? 70 : 90),
                  width: ResponsiveHelper.width(isMobile ? 70 : 90),
                  child: ResponsivePadding(
                    left: ResponsiveHelper.width(isMobile ? 10 : 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: mediumText(
                            ResponsiveHelper.sp(isMobile ? 9 : 3),
                            AppColor.blackColor,
                            null,
                          ),
                        ),
                        Gap(ResponsiveHelper.height(isMobile ? 3 : 3)),
                        Text(
                          name,
                          style: extraBoldText(
                            ResponsiveHelper.sp(isMobile ? 10 : 4),
                            AppColor.blackColor,
                            null,
                          ),
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
