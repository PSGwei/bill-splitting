import 'package:bill_splitter/models/person.dart';
import 'package:flutter/material.dart';

class EqualSplit extends StatelessWidget {
  const EqualSplit(
      {super.key,
      required this.totalBillAmount,
      required this.persons,
      required this.saveRecord});

  final double totalBillAmount;
  final List<Person> persons;
  final void Function() saveRecord;

  Widget build(BuildContext context) {
    double splittEquallyAmount = totalBillAmount / persons.length;
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'Split the bill by $totalBillAmount',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 50),
          ...persons.map((person) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.blue,
                    height: 100,
                    child: Center(
                      child: Text(
                        person.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: const Color.fromARGB(209, 161, 68, 10),
                    height: 100,
                    child: Center(
                      child: Text(splittEquallyAmount.toStringAsFixed(2)),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveRecord,
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
