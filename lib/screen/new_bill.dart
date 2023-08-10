import 'package:bill_splitter/screen/bill_split.dart';
import 'package:bill_splitter/models/bill.dart';
import 'package:bill_splitter/models/person.dart';
import 'package:flutter/material.dart';

class NewBill extends StatefulWidget {
  const NewBill({super.key});

  @override
  State<NewBill> createState() {
    return _NewBillState();
  }
}

class _NewBillState extends State<NewBill> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _personNamesController = TextEditingController();
  bool _splittingMethodSelected = false;

  List<String> personNames = [];
  List<Person> persons = [];
  List<Person> newPersons = [];

  void _onSelectMethodButton(
      BuildContext context, List<Person> persons, double totalAmount) async {
    final newPersons = await Navigator.of(context).push<List<Person>>(
      MaterialPageRoute(
          builder: (ctx) => BillSplitScreen(
                persons: persons,
                totalBillAmount: totalAmount,
              )),
    );
    setState(() {
      persons = newPersons!;
      _splittingMethodSelected = true;
    });
  }

  void onConfirmClick() {
    Navigator.of(context).pop(Bill(
        totalAmount: double.parse(_amountController.text),
        title: _titleController.text,
        payer: persons));
  }

  void _storeBill() {
    String input = _personNamesController.text.trim();
    personNames = input.split(',').map((name) => name.trim()).toList();
    persons = personNames.map((name) => Person(name: name, amount: 0)).toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _personNamesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new expense')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _personNamesController,
              decoration: const InputDecoration(
                labelText: 'Enter names (comma-separated)',
                hintText: 'John, Jane, Bob',
              ),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Amount'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (() {
                _storeBill();
                _onSelectMethodButton(
                    context, persons, double.parse(_amountController.text));
              }),
              child: const Text('Select Splitting Method'),
            ),
            const SizedBox(height: 50),
            if (_splittingMethodSelected)
              Center(
                child: ElevatedButton(
                  onPressed: onConfirmClick,
                  child: const Text('Confirm'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
