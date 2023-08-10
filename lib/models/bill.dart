import 'package:bill_splitter/models/person.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Bill {
  Bill({
    required this.totalAmount,
    required this.title,
    required this.payer,
  }) : id = uuid.v4();

  final String id;
  final double totalAmount;
  final String title;
  List<Person> payer;
}
