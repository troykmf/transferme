import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_responsive_widgets.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/home/data/receiber_details.dart';
import 'package:transferme/features/home/data/sender_details.dart';
import 'package:transferme/features/home/widgets/transaction_container_widget.dart';

class TransactionTypeView extends StatelessWidget {
  const TransactionTypeView({
    required this.transactionType,
    super.key,
    required this.lineChartName,
    required this.senderDetail,
    required this.receiverDetail,
    required this.isSenderOrReceiver,
  });

  final String transactionType;
  final String lineChartName;
  final List<SenderDetails> senderDetail;
  final List<ReceiberDetails> receiverDetail;
  final bool isSenderOrReceiver;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResponsivePadding(
          horizontal: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transactionType,
                style: headlineText(13, AppColor.textLightGreyColor, null),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: headlineText(11, AppColor.primaryColor, null),
                ),
              ),
            ],
          ),
        ),
        Gap(15),

        SizedBox(
          height: 210,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final sender = senderDetail[index];
              final receiver = receiverDetail[index];
              return TransactionTypeContainerWidget(
                lineChartName: lineChartName,
                name: isSenderOrReceiver ? sender.name : receiver.name,
                date: isSenderOrReceiver ? sender.date : receiver.date,
                amount: isSenderOrReceiver ? sender.amount : receiver.amount,
              );
            },
            itemCount: isSenderOrReceiver
                ? senderDetail.length
                : receiverDetail.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
