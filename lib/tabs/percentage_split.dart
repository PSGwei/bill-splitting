import 'package:bill_splitter/models/person.dart';
import 'package:flutter/material.dart';

class PercentageSplit extends StatelessWidget {
  const PercentageSplit({
    super.key,
    required this.totalBillAmount,
    required this.persons,
    required this.controllers,
    required this.saveRecord,
  });

  final double totalBillAmount;
  final List<Person> persons;
  final List<TextEditingController> controllers;
  final void Function() saveRecord;

  Widget build(BuildContext context) {
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: persons.length,
            itemBuilder: ((context, index) {
              return Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Colors.blue,
                      height: 100,
                      child: Center(
                        child: Text(
                          persons[index].name,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: const Color.fromARGB(255, 218, 232, 239),
                      height: 100,
                      child: Center(
                        child: SizedBox(
                          width: 100,
                          child: TextField(
                            controller: controllers[index],
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            decoration: const InputDecoration(
                              label: Text(
                                'Percentage',
                                style: TextStyle(fontSize: 13),
                              ),
                              suffix: Text('%'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveRecord,
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
