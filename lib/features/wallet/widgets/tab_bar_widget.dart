import 'package:transferme/core/util/app_assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/features/wallet/data/currency_data_model.dart';

class CurrencyTabBar extends StatefulWidget {
  const CurrencyTabBar({super.key});
  @override
  State<CurrencyTabBar> createState() => _CurrencyTabBarState();
}

class _CurrencyTabBarState extends State<CurrencyTabBar> {
  int selectedTab = 0;

  final List<CurrencyData> currencies = [
    CurrencyData(
      name: 'USD',
      value: '72.26',
      // isUp: false,
      // color: Color(0xFF5B6BC0), // Purple-blue color
    ),
    CurrencyData(
      name: 'Euro',
      value: '34.46',
      // isUp: true,
      // color: Color(0xFF4DD0E1), // Light blue/cyan
    ),
    CurrencyData(
      name: 'NGN',
      value: '95.31',
      // isUp: true,
      // color: Color(0xFF4DD0E1), // Light blue/cyan
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile;
    return Container(
      height: ResponsiveHelper.isMobile ? 80 : 100,
      width: ResponsiveHelper.isMobile ? 356 : 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.whiteColor,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: isMobile
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.spaceEvenly,
        children: currencies.asMap().entries.map((entry) {
          int index = entry.key;
          CurrencyData currency = entry.value;

          return Container(
            height: ResponsiveHelper.isMobile ? 56 : 70,
            width: ResponsiveHelper.isMobile ? 96 : 120,
            margin: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: selectedTab == index
                  ? AppColor.primaryColor
                  : AppColor.secondaryColor,
              borderRadius: BorderRadius.circular(20),
              // border: selectedTab == index
              //     ? Border.all(color: Colors.white, width: 2.5)
              //     : null,
              boxShadow: [
                // BoxShadow(
                //   color: currency.color.withOpacity(
                //     selectedTab == index ? 0.4 : 0.3,
                //   ),
                //   blurRadius: selectedTab == index ? 12 : 8,
                //   offset: Offset(0, selectedTab == index ? 6 : 4),
                // ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(ResponsiveHelper.isMobile ? 10 : 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currency.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveHelper.isMobile ? 12 : 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            selectedTab == index
                                ? SvgPicture.asset(
                                    width: isMobile ? 18 : 22,
                                    height: isMobile ? 18 : 22,
                                    AppSvgs.arrowReceive,
                                    colorFilter: ColorFilter.mode(
                                      AppColor.whiteColor,
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    width: isMobile ? 18 : 22,
                                    height: isMobile ? 18 : 22,
                                    AppSvgs.arrowSend,
                                    colorFilter: ColorFilter.mode(
                                      AppColor.whiteColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                            // Icon(
                            //   currency.isUp
                            //       ? Icons.trending_up_rounded
                            //       : Icons.trending_down_rounded,
                            //   color: Colors.white.withOpacity(0.8),
                            //   size: 18,
                            // ),
                            Text(
                              currency.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 12 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
