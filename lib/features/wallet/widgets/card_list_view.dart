import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transferme/features/home/data/card_remote_data_sources.dart';
import 'package:transferme/features/home/presentation/provider/card_provider.dart';
import 'package:transferme/features/wallet/presentation/add_card_color_page.dart';
import 'package:transferme/features/wallet/presentation/add_card_page.dart';
import 'package:transferme/features/wallet/widgets/card_widget.dart';

class CardListView extends StatelessWidget {
  const CardListView({super.key, required this.ref, required this.cards});

  final WidgetRef ref;
  final List<CardDetails> cards;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CardWidget(
          card: cards[index],
          onEditDetails: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCardPage(editingCard: cards[index]),
              ),
            );
          },
          onEditColor: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddCardColorScreen(cardDetails: cards[index]),
              ),
            );
          },
          onDelete: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Card'),
                content: Text(
                  'Are you sure you want to delete ${cards[index].holdersName}\'s card?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(cardProvider.notifier)
                          .deleteCard(cards[index].id!, context);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
