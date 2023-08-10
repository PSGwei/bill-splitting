import 'package:bill_splitter/models/bill.dart';
import 'package:bill_splitter/models/person.dart';
import 'package:bill_splitter/widgets/bill_item.dart';
import 'package:flutter/material.dart';
import 'package:bill_splitter/screen/new_bill.dart';

class Bills extends StatefulWidget {
  const Bills({super.key});

  @override
  State<Bills> createState() {
    return _BillsState();
  }
}

class _BillsState extends State<Bills> {
  List<Bill> bills = [];
  List<Person> result = [];

  void _addRecord() async {
    final result = await Navigator.of(context).push<Bill>(
      MaterialPageRoute(builder: (ctx) => const NewBill()),
    );

    setState(() {
      bills.add(result!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Splitter'),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecord,
        child: Expanded(
          child: Row(
            children: const [Icon(Icons.add), Text('Add')],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.builder(
          itemCount: bills.length,
          itemBuilder: (ctx, index) => BillItem(bills: bills, index: index)),
    );
  }
}
