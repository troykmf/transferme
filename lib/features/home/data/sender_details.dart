class SenderDetails {
  final String name;
  final String amount;
  final String? image;
  final String date;

  const SenderDetails({
    required this.name,
    required this.amount,
    required this.image,
    required this.date,
  });
}

final List<SenderDetails> senderDetails = [
  SenderDetails(
    name: 'John Doe',
    amount: '120.00',
    image: null,
    date: '23 December 2023',
  ),
  SenderDetails(
    name: 'Jane Smith',
    amount: '85.50',
    image: null,
    date: '24 December 2023',
  ),
  SenderDetails(
    name: 'Alice Johnson',
    amount: '200.00',
    image: null,
    date: '25 December 2023',
  ),
  SenderDetails(
    name: 'Bob Brown',
    amount: '150.75',
    image: null,
    date: '26 December 2023',
  ),
  SenderDetails(
    name: 'Charlie White',
    amount: '300.00',
    image: null,
    date: '27 December 2023',
  ),
  SenderDetails(
    name: 'Diana Green',
    amount: '175.25',
    image: null,
    date: '28 December 2023',
  ),
  SenderDetails(
    name: 'Ethan Blue',
    amount: '90.00',
    image: null,
    date: '29 December 2023',
  ),
];
