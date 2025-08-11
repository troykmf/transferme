import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/wallet/widgets/tab_bar_widget.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Card Details',
          style: headlineText(17, AppColor.blackColor, -0.5),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CurrencyTabBar(),
            Gap(30),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                onTap: () {},
                width: 153,
                buttonTitle: 'Add Card',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
