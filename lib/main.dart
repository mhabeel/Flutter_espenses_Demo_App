import 'dart:ui';
import 'dart:io';

import 'package:espenses_app/widget/transactions_list.dart';
import 'package:flutter/services.dart';

import './widget/new_transaction.dart';

import './widget/transactions_list.dart';

import 'package:flutter/material.dart';
import './model/transaction.dart';
import 'widget/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.copyWith(
            headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
            titleTextStyle:
                TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold)),
      ),
      title: 'Expenses App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;
  //  [
  //   Transaction(
  //       id: 't1', title: 'new shoes', amount: 12.99, date: DateTime.now()),
  //   Transaction(id: 't2', title: 'food', amount: 23.99, date: DateTime.now()),
  // ];

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return (tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))));
    }).toList();
  }

  void addTransaction(String title, double amount, DateTime date) {
    final neTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      _userTransactions.add(neTx);
    });
  }

  void removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTransaction);
        });
  }

  Widget builderLandscape() {
    return Column(

        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Show chart'),
              Switch.adaptive(
                  // it will render on the device depending on its os
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  })
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          _showChart
              ? Container(
                  // color: Colors.blue,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,

                  //padding: EdgeInsets.all(10),
                  child: Chart(recentTransactions),
                )
              :
              // UserTransactions()
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: TransactionList(_userTransactions, removeTransaction),
                )
        ]);
  }

  Widget builderPortrait() {
    return Column(

        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,

            //padding: EdgeInsets.all(10),
            child: Chart(recentTransactions),
          ),

          // UserTransactions()
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: TransactionList(_userTransactions, removeTransaction),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    print('myhomepage build');
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ?
          // if the op is ios -> no floatingbutton
          Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => startAddnewTransaction(context),
              // backgroundColor: Color.fromARGB(220, 23, 193, 20),
            ),
      appBar: AppBar(
        title: Text(
          'Expenses App',
          // style: TextStyle(fontFamily: 'OpenSans',
          //  fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => startAddnewTransaction(context),
            icon: Icon(Icons.add),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: !isLandscape ? builderPortrait() : builderLandscape(),
      ),
    );
  }
}
