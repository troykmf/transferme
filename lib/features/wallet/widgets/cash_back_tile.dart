import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transferme/core/util/app_assets.dart';
import 'package:transferme/core/util/app_color.dart';
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
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            width: 57,
            height: 57,
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
              14,
              AppColor.blackColor,
              -.05,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(time, style: smallText(10, AppColor.blackColor, -.05)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset(
                AppSvgs.arrowReceive,
                colorFilter: ColorFilter.mode(
                  AppColor.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              Text(price, style: extraBoldText(14, AppColor.primaryColor, -.5)),
            ],
          ),
        ),
      ),
    );
  }
}
