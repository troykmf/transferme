import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String appBarTitle;
//   final double height;
//   final Gap? gap;

//   const CustomAppBar({
//     required this.appBarTitle,
//     this.height = kToolbarHeight,
//     this.gap,
//     super.key,
//   });

//   @override
//   Size get preferredSize => Size.fromHeight(height);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: preferredSize.height,
//       color: Colors.red,
//       child: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: ResponsiveContainer(
//                   decoration: BoxDecoration(
//                     color: AppColor.primaryColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   width: 50,
//                   height: 25,
//                   child: Icon(
//                     Icons.arrow_back,
//                     color: AppColor.whiteColor,
//                     size: 15,
//                   ),
//                 ),
//               ),
//               gap ?? Gap(65),
//               Text(
//                 appBarTitle,
//                 style: headlineText(16, AppColor.blackColor, null),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:transferme/core/util/app_responsive_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final double height;
  final Gap? gap;

  const CustomAppBar({
    required this.appBarTitle,
    this.height = kToolbarHeight,
    this.gap,
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(ResponsiveHelper.height(height));

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile;
    return Container(
      height: preferredSize.height,
      color: Colors.red,
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.fromLTRB(ResponsiveHelper.width(20), 0, 0, 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: ResponsiveContainer(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.width(20),
                    ),
                  ),
                  width: ResponsiveHelper.width(isMobile ? 50 : 22),
                  height: ResponsiveHelper.height(isMobile ? 25 : 25),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.whiteColor,
                      size: ResponsiveHelper.sp(isMobile ? 15 : 13),
                    ),
                  ),
                ),
              ),
              gap ?? Gap(ResponsiveHelper.width(isMobile ? 65 : 50)),
              Text(
                appBarTitle,
                style: headlineText(
                  ResponsiveHelper.sp(isMobile ? 16 : 8),
                  AppColor.blackColor,
                  null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
