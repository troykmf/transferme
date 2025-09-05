import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/home/data/receiber_details.dart';
import 'package:transferme/features/home/data/sender_details.dart';
import 'package:transferme/features/home/widgets/transaction_container_widget.dart';

// class TransactionTypeView extends StatelessWidget {
//   const TransactionTypeView({
//     required this.transactionType,
//     super.key,
//     required this.lineChartName,
//     required this.senderDetail,
//     required this.receiverDetail,
//     required this.isSenderOrReceiver,
//     required this.arrowType,
//   });

//   final String transactionType;
//   final String lineChartName;
//   final List<SenderDetails> senderDetail;
//   final List<ReceiberDetails> receiverDetail;
//   final bool isSenderOrReceiver;
//   final String arrowType;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ResponsivePadding(
//           horizontal: 16.0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 transactionType,
//                 style: headlineText(13, AppColor.textLightGreyColor, null),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'See All',
//                   style: headlineText(11, AppColor.primaryColor, null),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Gap(15),

//         SizedBox(
//           height: 210,
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               final sender = senderDetail[index];
//               final receiver = receiverDetail[index];
//               return TransactionTypeContainerWidget(
//                 lineChartName: lineChartName,
//                 name: isSenderOrReceiver ? sender.name : receiver.name,
//                 date: isSenderOrReceiver ? sender.date : receiver.date,
//                 amount: isSenderOrReceiver ? sender.amount : receiver.amount,
//                 arrowType: arrowType,
//                 amountColor: isSenderOrReceiver
//                     ? AppColor.secondaryColor
//                     : AppColor.primaryColor,
//               );
//             },
//             itemCount: isSenderOrReceiver
//                 ? senderDetail.length
//                 : receiverDetail.length,
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             padding: EdgeInsets.zero,
//             scrollDirection: Axis.horizontal,
//           ),
//         ),
//       ],
//     );
//   }
// }

class TransactionTypeView extends StatelessWidget {
  const TransactionTypeView({
    required this.transactionType,
    super.key,
    required this.lineChartName,
    required this.senderDetail,
    required this.receiverDetail,
    required this.isSenderOrReceiver,
    required this.arrowType,
  });

  final String transactionType;
  final String lineChartName;
  final List<SenderDetails> senderDetail;
  final List<ReceiberDetails> receiverDetail;
  final bool isSenderOrReceiver;
  final String arrowType;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.width(isMobile ? 16 : 14),
            vertical: ResponsiveHelper.height(isMobile ? 0 : 5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transactionType,
                style: headlineText(
                  ResponsiveHelper.sp(isMobile ? 13 : 5),
                  AppColor.textLightGreyColor,
                  null,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: headlineText(
                    ResponsiveHelper.sp(isMobile ? 11 : 5),
                    AppColor.primaryColor,
                    null,
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(ResponsiveHelper.height(isMobile ? 10 : 15)),
        LayoutBuilder(
          builder: (context, constraints) {
            // final itemWidth =
            //     ResponsiveHelper.width(isMobile ? 148 : 74) +
            //     ResponsiveHelper.width(isMobile ? 16 : 8); // Include margin
            // final visibleItems = (constraints.maxWidth / itemWidth).floor();
            final itemCount = isSenderOrReceiver
                ? senderDetail.length
                : receiverDetail.length;
            // Ensure at least 1 item, up to available items
            final displayCount = itemCount;
            // final displayCount = visibleItems.clamp(1, itemCount);

            return SizedBox(
              height: ResponsiveHelper.height(isMobile ? 210 : 270),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final sender = senderDetail[index];
                  final receiver = receiverDetail[index];
                  return TransactionTypeContainerWidget(
                    lineChartName: lineChartName,
                    name: isSenderOrReceiver ? sender.name : receiver.name,
                    date: isSenderOrReceiver ? sender.date : receiver.date,
                    amount: isSenderOrReceiver
                        ? sender.amount
                        : receiver.amount,
                    arrowType: arrowType,
                    amountColor: isSenderOrReceiver
                        ? AppColor.secondaryColor
                        : AppColor.primaryColor,
                  );
                },
                itemCount: displayCount,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
              ),
            );
          },
        ),
      ],
    );
  }
}
