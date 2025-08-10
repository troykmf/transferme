// import 'package:flutter/material.dart';

// class TransactionTypeListTile extends StatelessWidget {
//   const TransactionTypeListTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//           height: 210,
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               return TransactionTypeContainerWidget(
//                 lineChartName: lineChartName,
//                 name: name,
//                 date: date,
//                 amount: amount,
//               );
//             },
//             itemCount: 10,
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             padding: EdgeInsets.zero,
//             scrollDirection: Axis.horizontal,
//           ),
//         );
//   }
// }