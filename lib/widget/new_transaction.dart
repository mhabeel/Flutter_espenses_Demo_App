import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function inputTx;
  NewTransaction(this.inputTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titelController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    print('newTx build');
    void submit() {
      if (titelController.text.isEmpty ||
          double.parse(amountController.text) <= 0) {
        return;
      }
      widget.inputTx(titelController.text, double.parse(amountController.text),
          selectedDate);
      Navigator.of(context).pop();
    }

    void setDate() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime.now())
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          selectedDate = pickedDate;
        });
      });
    }

    return Card(
      elevation: 9,
      child: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titelController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              ),
              Row(
                children: [
                  FlatButton(
                    onPressed: () => setDate(),
                    child: Text('set Date'),
                    textColor: Theme.of(context).primaryColor,
                  ),
                  Text(
                    selectedDate == null
                        ? 'No Date yet'
                        : DateFormat.yMd().format(selectedDate as DateTime),
                  )
                ],
              ),
              FlatButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: submit,
              )
            ],
          ),
        ),
      ),
    );
    //transactions
  }
}
