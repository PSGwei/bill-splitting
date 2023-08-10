import 'package:bill_splitter/models/person.dart';
import 'package:flutter/material.dart';

class CustomAmountSplit extends StatefulWidget {
  CustomAmountSplit({
    super.key,
    required this.tempTotalBillAmount,
    required this.persons,
    required this.controllers,
    required this.saveRecord,
  });

  double tempTotalBillAmount;
  final List<Person> persons;
  final List<TextEditingController> controllers;
  final void Function(double billAmount) saveRecord;

  @override
  State<CustomAmountSplit> createState() {
    return _EqualSplitState();
  }
}

class _EqualSplitState extends State<CustomAmountSplit> {
  double oldValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'Split the bill by ${widget.tempTotalBillAmount}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 50),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.persons.length,
            itemBuilder: (context, index) {
              TextEditingController controller = widget.controllers[index];
              String oldValue = controller.text; // Store the old value
              return ListTile(
                title: Text(widget.persons[index].name),
                subtitle: TextFormField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      double newValue = double.tryParse(value) ?? 0;
                      double oldAmount = double.tryParse(oldValue) ?? 0;
                      widget.tempTotalBillAmount =
                          widget.tempTotalBillAmount + oldAmount - newValue;

                      widget.persons[index].amount = newValue;

                      oldValue = value; // Update the old value
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefix: Text('\$'),
                      labelText: 'Enter amount',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.saveRecord(widget.tempTotalBillAmount);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
