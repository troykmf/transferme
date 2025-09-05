import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transferme/core/util/app_assets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

class CashBackTile extends StatelessWidget {
  const CashBackTile({
    super.key,
    required this.title,
    required this.price,
    required this.time,
    required this.icon,
    required this.color,
  });

  final String title;
  final String price;
  final String time;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile;
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
            offset: Offset(4, 5), // changes position of shadow
          ),
        ],
      ),

      child: Center(
        child: ListTile(
          leading: Container(
            width: isMobile ? 57 : 57,
            height: isMobile ? 57 : 57,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(icon, color: AppColor.whiteColor, size: 18),
            ),
          ),
          title: Text(
            title,
            style: extraBoldText(
              isMobile ? 14 : 9,
              AppColor.blackColor,
              -.05,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            time,
            style: smallText(isMobile ? 10 : 7, AppColor.blackColor, -.05),
          ),
          trailing: Column(
            mainAxisAlignment: isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset(
                AppSvgs.arrowReceive,
                colorFilter: ColorFilter.mode(
                  AppColor.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                price,
                style: extraBoldText(
                  isMobile ? 14 : 9,
                  AppColor.primaryColor,
                  -.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
