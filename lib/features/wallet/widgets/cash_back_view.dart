import 'package:flutter/material.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/wallet/data/cash_back_data_model.dart';
import 'package:transferme/features/wallet/widgets/cash_back_tile.dart';

class CashBackView extends StatelessWidget {
  const CashBackView({super.key, required this.cashBackList});

  final List<CashBackDataModel> cashBackList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ResponsivePadding(
            horizontal: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cash Backs',
                  style: headlineText(13, AppColor.textLightGreyColor, -.5),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All >',
                    style: smallText(11, AppColor.primaryColor, null),
                  ),
                ),
              ],
            ),
          ),
          // Gap(10),
          Expanded(
            // height: ResponsiveHelper.height(500),
            child: ListView.builder(
              itemCount: cashBackList.length,
              itemBuilder: (context, index) {
                final eachCashBack = cashBackList.elementAt(index);
                return CashBackTile(
                  title: eachCashBack.title,
                  price: eachCashBack.amount,
                  time: eachCashBack.time,
                  icon: eachCashBack.icon,
                  color: eachCashBack.color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
