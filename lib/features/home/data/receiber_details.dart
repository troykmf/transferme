class ReceiberDetails {
  final String name;
  final String amount;
  final String? image;
  final String date;

  const ReceiberDetails({
    required this.name,
    required this.amount,
    required this.image,
    required this.date,
  });

}

final List<ReceiberDetails> receiverDetails = [
  ReceiberDetails(
    name: 'Alice Johnson',
    amount: '200.00',
    image: null,
    date: '25 December 2023',
  ),
  ReceiberDetails(
    name: 'Bob Brown',
    amount: '150.75',
    image: null,
    date: '26 December 2023',
  ),
  ReceiberDetails(
    name: 'Charlie White',
    amount: '300.00',
    image: null,
    date: '27 December 2023',
  ),
  ReceiberDetails(
    name: 'Diana Green',
    amount: '175.25',
    image: null,
    date: '28 December 2023',       
  ),
  ReceiberDetails(
    name: 'Ethan Blue',
    amount: '90.00',
    image: null,
    date: '29 December 2023',
  ),
  ReceiberDetails(
    name: 'Frank Black',
    amount: '120.00',
    image: null,
    date: '30 December 2023',
  ),
  ReceiberDetails(
    name: 'Grace Yellow',
    amount: '80.50',
    image: null,
    date: '31 December 2023',
  ),
];
