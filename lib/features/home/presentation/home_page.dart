import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_assets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/home/data/receiber_details.dart';
import 'package:transferme/features/home/data/sender_details.dart';
import 'package:transferme/features/home/widgets/transaction_type_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ReceiberDetails> receiverDetail = receiverDetails;
  final List<SenderDetails> senderDetail = senderDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.menu),
        actions: [SvgPicture.asset(AppSvgs.notificationIcon)],
        actionsPadding: EdgeInsets.only(right: 16.0),
      ),
      body: SafeArea(
        child: ResponsivePadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              ResponsivePadding(
                left: 16.0,
                child: Text(
                  'Current Balance',
                  style: headlineText(13, AppColor.textLightGreyColor, null),
                ),
              ),

              ResponsivePadding(
                left: 16.0,
                child: Text(
                  '\$285,378.20',
                  style: extraBoldText(27, AppColor.primaryColor, -1),
                ),
              ),
              Gap(20),
              TransactionTypeView(
                transactionType: 'Incoming Transactions',
                lineChartName: AppSvgs.incomingLineCurve,
                senderDetail: senderDetail,
                receiverDetail: receiverDetail,
                isSenderOrReceiver: true,
              ),
              Gap(20),
              TransactionTypeView(
                transactionType: 'Outgoing Transactions',
                lineChartName: AppSvgs.outgoingLineCurve,
                senderDetail: senderDetail,
                receiverDetail: receiverDetail,
                isSenderOrReceiver: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
