import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/custom/custom_button.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';
import 'package:transferme/features/home/presentation/provider/card_provider.dart';
import 'package:transferme/features/wallet/data/cash_back_data_model.dart';
import 'package:transferme/features/wallet/presentation/add_card_page.dart';
import 'package:transferme/features/wallet/widgets/card_list_view.dart';
import 'package:transferme/features/wallet/widgets/cash_back_view.dart';
import 'package:transferme/features/wallet/widgets/tab_bar_widget.dart';

class WalletsPage extends ConsumerWidget {
  const WalletsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveHelper.isMobile;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Card Details',
          style: headlineText(isMobile ? 17 : 12, AppColor.blackColor, -0.5),
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
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddCardPage(),
                    ),
                  );
                },
                width: isMobile ? 153 : 120,
                buttonTitle: 'Add Card',
              ),
            ),
            Expanded(
              child: ref
                  .watch(cardsProvider)
                  .when(
                    data: (cards) {
                      if (cards.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.credit_card_off,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No cards found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add your first card to get started',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        );
                      }
                      return CardListView(ref: ref, cards: cards);
                    },
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                    error: (e, s) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text('Error: $e'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ref.refresh(cardsProvider),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
            CashBackView(cashBackList: cashBackDataList),
          ],
        ),
      ),
    );
  }
}
