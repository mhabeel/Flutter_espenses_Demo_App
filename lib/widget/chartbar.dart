//import 'dart:html';

import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String day;
  final double amount;
  final double percentage;
  Chartbar(this.day, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrait) {
      return Column(
        children: [
          Container(
            child: Text(day),
            height: constrait.maxHeight * 0.15,
          ),
          SizedBox(
            height: constrait.maxHeight * 0.05,
          ),
          Container(
            height: constrait.maxHeight * 0.6,
            width: 10,
            // color: Colors.blue,
            // margin: EdgeInsets.symmetric(horizontal: 2.1),
            // decoration: BoxDecoration(
            //     border: Border.all(color: Colors.black38, width: 2),
            //     borderRadius: BorderRadius.circular(100)),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromARGB(255, 87, 118, 203),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constrait.maxHeight * 0.05,
          ),
          Container(
            height: constrait.maxHeight * 0.15,
            width: 50,
            child: FittedBox(
              child: Text('\$ $amount'),
            ),
          ),
        ],
      );
    });

    //);
  }
}
