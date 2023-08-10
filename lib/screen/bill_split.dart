import 'package:bill_splitter/models/person.dart';
import 'package:bill_splitter/tabs/custom_amount.dart';
import 'package:bill_splitter/tabs/equal_split.dart';
import 'package:bill_splitter/tabs/percentage_split.dart';
import 'package:flutter/material.dart';

class BillSplitScreen extends StatefulWidget {
  BillSplitScreen(
      {super.key, required this.persons, required this.totalBillAmount});

  final List<Person> persons;
  double totalBillAmount;

  @override
  State<BillSplitScreen> createState() {
    return _BillSplitScreenState();
  }
}

class _BillSplitScreenState extends State<BillSplitScreen> {
  double splittEquallyAmount = 0;
  double tempTotal = 0;
  List<TextEditingController> _amountControllers = [];
  List<TextEditingController> _percentageControllers = [];

  @override
  void initState() {
    // Initialize the controllers and temp_total
    _amountControllers = List.generate(
      widget.persons.length,
      (index) => TextEditingController(),
    );

    _percentageControllers = List.generate(
      widget.persons.length,
      (index) => TextEditingController(),
    );

    tempTotal = widget.totalBillAmount;
    super.initState();
  }

  // tabbar
  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(text: 'Equally'),
          Tab(text: 'Custom Amount'),
          Tab(text: 'By Percentage'),
        ],
      );

  void _saveRecordForEqualSplit() {
    for (int i = 0; i < widget.persons.length; i++) {
      widget.persons[i].amount = splittEquallyAmount;
    }
    Navigator.of(context).pop(widget.persons);
  }

  //AlertDialogBox
  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OKAY'),
          ),
        ],
      ),
    );
  }

  void _saveRecordForCustomAmountSplit(double updatedTempTotalBillAmount) {
    if (updatedTempTotalBillAmount < 0) {
      _showErrorDialog('Error', 'Over original Total Bill Amount!');

      //clear the textfield and reset the totalAmount
      setState(() {
        _amountControllers.forEach((controller) => controller.clear());
        tempTotal = widget.totalBillAmount;
      });
      return;
    } else if (updatedTempTotalBillAmount != widget.totalBillAmount) {
      _showErrorDialog('Error', 'The amount has not been fully allocated');
    } else {
      Navigator.of(context).pop(widget.persons); //back to previous screen
    }
  }

  void _saveRecordForPercentageSplit() {
    int sumPercentage = 0;
    for (TextEditingController controller in _percentageControllers) {
      sumPercentage += int.tryParse(controller.text) ?? 0;
    }

    if (sumPercentage != 100) {
      _showErrorDialog('Error', 'Make sure total percentage is 100');
    } else {
      for (int i = 0; i < _percentageControllers.length; i++) {
        widget.persons[i].amount =
            (double.tryParse(_percentageControllers[i].text) ?? 0) *
                (widget.totalBillAmount / 100);
      }
      Navigator.of(context).pop(widget.persons);
    }
  }

  @override
  Widget build(BuildContext context) {
    splittEquallyAmount = widget.totalBillAmount / widget.persons.length;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Split Method'),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: Colors.red,
              child: _tabBar,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(children: [
                EqualSplit(
                  totalBillAmount: widget.totalBillAmount,
                  persons: widget.persons,
                  saveRecord: _saveRecordForEqualSplit,
                ),
                CustomAmountSplit(
                  tempTotalBillAmount: tempTotal,
                  persons: widget.persons,
                  controllers: _amountControllers,
                  saveRecord: _saveRecordForCustomAmountSplit,
                ),
                PercentageSplit(
                  totalBillAmount: widget.totalBillAmount,
                  persons: widget.persons,
                  controllers: _percentageControllers,
                  saveRecord: _saveRecordForPercentageSplit,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
