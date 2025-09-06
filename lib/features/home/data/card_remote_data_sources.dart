import 'package:cloud_firestore/cloud_firestore.dart';

class CardDetails {
  String? id;
  String cardNumber;
  String holdersName;
  String expiryDate;
  String cvv;
  String color;
  DateTime date;
  String cardType;

  CardDetails({
    this.id,
    required this.cardNumber,
    required this.holdersName,
    required this.expiryDate,
    required this.cvv,
    required this.color,
    required this.date,
    required this.cardType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'holdersName': holdersName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'color': color,
      'date': date.toIso8601String(),
      'cardType': cardType,
    };
  }

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      id: json['id'],
      cardNumber: json['cardNumber'] ?? '',
      holdersName: json['holdersName'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      cvv: json['cvv'] ?? '',
      color: json['color'] ?? '',
      date: DateTime.parse(json['date']),
      cardType: json['cardType'] ?? '',
    );
  }

  factory CardDetails.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CardDetails(
      id: doc.id,
      cardNumber: data['cardNumber'] ?? '',
      holdersName: data['holdersName'] ?? '',
      expiryDate: data['expiryDate'] ?? '',
      cvv: data['cvv'] ?? '',
      color: data['color'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      cardType: data['cardType'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'cardNumber': cardNumber,
      'holdersName': holdersName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'color': color,
      'date': Timestamp.fromDate(date),
      'cardType': cardType,
    };
  }
}

class CardRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'cards';

  Future<String?> createCard(CardDetails card) async {
    try {
      DocumentReference docRef = await _firestore
          .collection(_collectionName)
          .add(card.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create card: $e');
    }
  }

  Future<List<CardDetails>> getAllCards() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => CardDetails.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to retrieve cards: $e');
    }
  }

  Future<void> updateCard(CardDetails card) async {
    try {
      if (card.id == null) {
        throw Exception('Card ID is required for update operation');
      }
      await _firestore
          .collection(_collectionName)
          .doc(card.id)
          .update(card.toFirestore());
    } catch (e) {
      throw Exception('Failed to update card: $e');
    }
  }

  Future<void> deleteCard(String cardId) async {
    try {
      await _firestore.collection(_collectionName).doc(cardId).delete();
    } catch (e) {
      throw Exception('Failed to delete card: $e');
    }
  }

  Stream<List<CardDetails>> getCardsStream() {
    return _firestore
        .collection(_collectionName)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => CardDetails.fromFirestore(doc))
              .toList();
        });
  }
}

class CardValidator {
  static bool validateCardNumber(String cardNumber) {
    String cleanNumber = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (cleanNumber.length < 13 || cleanNumber.length > 19) return false;

    int sum = 0;
    bool isEven = false;

    for (int i = cleanNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }

  static bool validateExpiryDate(String expiryDate) {
    RegExp regex = RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$');
    if (!regex.hasMatch(expiryDate)) return false;

    List<String> parts = expiryDate.split('/');
    int month = int.parse(parts[0]);
    int year = 2000 + int.parse(parts[1]);

    DateTime now = DateTime.now();
    DateTime expiry = DateTime(year, month);

    return expiry.isAfter(now);
  }

  static bool validateCVV(String cvv) {
    return RegExp(r'^[0-9]{3,4}$').hasMatch(cvv);
  }

  static String detectCardType(String cardNumber) {
    String cleanNumber = cardNumber.replaceAll(RegExp(r'\s+'), '');

    if (RegExp(r'^4').hasMatch(cleanNumber)) return 'Visa';
    if (RegExp(r'^5[1-5]').hasMatch(cleanNumber)) return 'MasterCard';
    if (RegExp(r'^3[47]').hasMatch(cleanNumber)) return 'American Express';
    if (RegExp(r'^6(?:011|5)').hasMatch(cleanNumber)) return 'Discover';

    return 'Unknown';
  }
}
