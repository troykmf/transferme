import 'package:flutter/material.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/home/data/card_remote_data_sources.dart';

class CardWidget extends StatelessWidget {
  final CardDetails card;
  final VoidCallback onEditDetails;
  final VoidCallback onEditColor;
  final VoidCallback onDelete;

  const CardWidget({
    Key? key,
    required this.card,
    required this.onEditDetails,
    required this.onEditColor,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile;
    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 8),
      child: Stack(
        children: [
          Container(
            height: isMobile ? 173 : 173,
            width: isMobile ? 350 : 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getCardColors(card.color),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card.cardType,
                        style: headlineText(
                          isMobile ? 14 : 7,
                          AppColor.whiteColor,
                          null,
                        ),
                      ),
                      Icon(
                        _getCardTypeIcon(card.cardType),
                        color: AppColor.whiteColor,
                        size: isMobile ? 25 : 20,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    _formatCardNumber(card.cardNumber),
                    style: extraBoldText(
                      isMobile ? 18 : 12,
                      AppColor.whiteColor,
                      2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CARD HOLDER',
                            style: mediumText(
                              isMobile ? 10 : 6,
                              AppColor.whiteColor.withOpacity(0.7),
                              null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            card.holdersName.toUpperCase(),
                            style: headlineText(
                              isMobile ? 14 : 8,
                              AppColor.whiteColor,
                              null,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EXPIRES',
                            style: mediumText(
                              isMobile ? 10 : 6,
                              AppColor.whiteColor.withOpacity(0.7),
                              null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            card.expiryDate,
                            style: headlineText(
                              isMobile ? 14 : 8,
                              AppColor.whiteColor,
                              null,
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
          Positioned(
            top: isMobile ? 8 : 8,
            right: isMobile ? 8 : 8,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {
                if (value == 'edit_details') {
                  onEditDetails();
                } else if (value == 'edit_color') {
                  onEditColor();
                } else if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit_details',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: isMobile ? 20 : 12),
                      SizedBox(width: isMobile ? 8 : 4),
                      Text(
                        'Edit Details',
                        style: mediumText(
                          isMobile ? 14 : 8,
                          AppColor.blackColor,
                          null,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'edit_color',
                  child: Row(
                    children: [
                      Icon(Icons.color_lens, size: isMobile ? 20 : 12),
                      SizedBox(width: isMobile ? 8 : 4),
                      Text(
                        'Edit Color',
                        style: mediumText(
                          isMobile ? 14 : 8,
                          AppColor.blackColor,
                          null,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: isMobile ? 20 : 12,
                        color: Colors.red,
                      ),
                      SizedBox(width: isMobile ? 8 : 4),
                      Text(
                        'Delete',
                        style: mediumText(isMobile ? 14 : 8, Colors.red, null),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getCardColors(String color) {
    switch (color.toLowerCase()) {
      case 'light blue':
        return [const Color(0xFF7DD3E8), const Color(0xFF2196F3)];
      case 'green':
        return [const Color(0xFF4CAF50), const Color(0xFF1B5E20)];
      case 'blue':
        return [const Color(0xFF2196F3), const Color(0xFF0D47A1)];
      case 'orange':
        return [const Color(0xFFFF9800), const Color(0xFFF57C00)];
      case 'red-orange':
        return [const Color(0xFFFF5722), const Color(0xFFD81B60)];
      case 'cyan':
        return [const Color(0xFF00BCD4), const Color(0xFF00838F)];
      case 'red':
        return [const Color(0xFFF44336), const Color(0xFFB71C1C)];
      case 'yellow':
        return [const Color(0xFFFFEB3B), const Color(0xFFFBC02D)];
      case 'grey':
        return [const Color(0xFF9E9E9E), const Color(0xFF616161)];
      case 'dark grey':
        return [const Color(0xFF424242), const Color(0xFF212121)];
      case 'black':
        return [const Color(0xFF000000), const Color(0xFF000000)];
      case 'dark blue':
        return [const Color(0xFF1A237E), const Color(0xFF0D47A1)];
      case 'navy blue':
        return [const Color(0xFF0D47A1), const Color(0xFF01579B)];
      case 'purple':
        return [const Color(0xFF6A1B9A), const Color(0xFF4A148C)];
      case 'light purple':
        return [const Color(0xFF7986CB), const Color(0xFF5C6BC0)];
      default:
        return [const Color(0xFF7DD3E8), const Color(0xFF2196F3)];
    }
  }

  IconData _getCardTypeIcon(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return Icons.payment;
      case 'mastercard':
        return Icons.credit_card;
      case 'american express':
        return Icons.credit_card;
      case 'discover':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  String _formatCardNumber(String cardNumber) {
    return cardNumber.replaceAllMapped(
      RegExp(r'(\d{4})(?=\d)'),
      (match) => '${match.group(1)} ',
    );
  }
}
