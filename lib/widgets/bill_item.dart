import 'package:bill_splitter/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BillItem extends StatelessWidget {
  const BillItem({super.key, required this.bills, required this.index});

  final List<Bill> bills;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              // share the result
              Share.share(''' 
                Following is the bill spliting result:
                title: ${bills[index].title}
                total amount: ${bills[index].totalAmount.toString()}
                person: 
                ${bills[index].payer.map((person) => '${person.name} : ${person.amount.toStringAsFixed(2)}').join('\n')}
              ''');
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Text(bills[index].title),
                    Text(bills[index].totalAmount.toString()),
                    for (final person in bills[index].payer)
                      Row(
                        children: [
                          Text(person.name),
                          const Spacer(),
                          Text(person.amount.toStringAsFixed(2)),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
