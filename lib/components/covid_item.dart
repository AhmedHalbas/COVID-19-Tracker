import 'package:covid19/services/covid19.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/reusable_card.dart';
import '../utilities/constants.dart';

class CovidItem extends StatelessWidget {
  final bool isWaiting;
  final NumberFormat formatter;
  final String itemText;
  final int itemValue;
  final String deathPercentage;

  CovidItem({
    @required this.itemText,
    @required this.itemValue,
    @required this.isWaiting,
    @required this.formatter,
    this.deathPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReusableCard(
        colour: kActiveCardColour,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              itemText,
              style: kLabelTextStyle,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${isWaiting ? '?' : formatter.format(itemValue)}',
                      style: kNumberTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    deathPercentage != null
                        ? Text(
                            '${isWaiting ? '?' : deathPercentage}%',
                            style: kLabelTextStyle,
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
