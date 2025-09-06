import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transferme/core/util/helpers/helper_dialogs.dart';
import 'package:transferme/core/util/helpers/validation_helper.dart';
import 'package:transferme/features/home/data/card_remote_data_sources.dart';
import 'package:transferme/features/wallet/presentation/wallets_page.dart';

class CardState {
  final bool isLoading;
  final String? errorMessage;

  CardState({
    this.isLoading = false,
    this.errorMessage,
  });

  CardState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) => CardState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class CardNotifier extends StateNotifier<CardState> {
  final CardRemoteDataSource _cardRemoteDataSource;

  CardNotifier(this._cardRemoteDataSource) : super(CardState());

  Future<void> saveCard(CardDetails card, BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);
      if (card.id == null) {
        await _cardRemoteDataSource.createCard(card);
      } else {
        await _cardRemoteDataSource.updateCard(card);
      }
      Navigator.pop(context);
      HelperDialogs().showHelperDialog(
        context,
        "Success",
        'Card ${card.id == null ? 'added' : 'updated'} successfully',
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WalletsPage()),
            (route) => false,
          );
        },
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      Navigator.pop(context);
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
      showErrorDialog(context, e.toString(), StackTrace.current);
      log(e.toString());
    }
  }

  Future<void> deleteCard(String cardId, BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      showLoadingDialog(context);
      await _cardRemoteDataSource.deleteCard(cardId);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Card deleted successfully')),
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      Navigator.pop(context);
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
      showErrorDialog(context, e.toString(), StackTrace.current);
      log(e.toString());
    }
  }
}

final cardProvider = StateNotifierProvider<CardNotifier, CardState>((ref) {
  final cardRemoteDataSource = CardRemoteDataSource();
  return CardNotifier(cardRemoteDataSource);
});

final cardsProvider = StreamProvider<List<CardDetails>>((ref) {
  return CardRemoteDataSource().getCardsStream();
});

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
}

void showErrorDialog(
  BuildContext context,
  String message,
  StackTrace? stackTrace,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}