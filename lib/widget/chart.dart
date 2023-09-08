import 'dart:ffi';
//import 'dart:js_util';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../model/transaction.dart';
import 'package:intl/intl.dart';
import 'chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var total = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          total += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': total};
    });
  }

  double percante = 0;
  double get rate {
    double result = 0;
    for (int i = 0; i < groupedTransactionsValues.length; i++) {
      result += (groupedTransactionsValues[i]['amount'] as double);
    }
    percante = result;
    return percante;
  }

  double get totalPer {
    return groupedTransactionsValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    print('chart build');
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Card(
        // margin: EdgeInsets.all(20),
        elevation: 6,
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...groupedTransactionsValues
                  .map((e) {
                    return Flexible(
                      fit: FlexFit.tight,
                      child: Chartbar(
                          e['day'] as String,
                          e['amount'] as double,
                          rate == 0
                              ? 1
                              : (((e['amount'] as double) / rate) - 1).abs()),
                    );
                  })
                  .toList()
                  .reversed,
            ]),
      ),
    );
  }
}
