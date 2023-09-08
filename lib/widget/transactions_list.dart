import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context); // to save the object once only
    return Container(
      // height: MediaQuery.of(context).size.height * 0.7,
      child: transactions.isEmpty
          ? Column(children: [
              Container(
                height: mediaQuery.size.height * 0.1,
                child: Text(
                  'No Transactions yet',
                ),
              ),
              SizedBox(
                // to make empty space between 2 elemnts
                height: mediaQuery.size.height * 0.05,
              ),
              Center(
                child: Container(
                  height: mediaQuery.size.height * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover, // to squeez the image into box
                    color: Colors.blue,
                  ),

                  // margin: EdgeInsets.symmetric(horizontal: 105, vertical: 20),
                  //width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black, width: 3)),
                ),
              ),
            ])
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                    elevation: 6,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}'),
                          ),
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        transactions[index].title,
                      ),
                      subtitle: Text(
                        DateFormat.yMEd().format(transactions[index].date),
                      ),
                      trailing: mediaQuery.size.width > 400
                          ? FlatButton.icon(
                              onPressed: (() {
                                removeTransaction(transactions[index].id);
                              }),
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              textColor: Theme.of(context).errorColor,
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (() {
                                removeTransaction(transactions[index].id);
                              }),
                              color: Theme.of(context).errorColor,
                            ),
                    ));
              },
            ),
    );
  }
}
