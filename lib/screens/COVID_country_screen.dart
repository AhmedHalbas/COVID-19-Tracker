import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/COVID.dart';
import '../components/reusable_card.dart';
import '../utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class COVIDCountryScreen extends StatefulWidget {
  final String selectedCountry;

  COVIDCountryScreen({@required this.selectedCountry});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<COVIDCountryScreen> {
  Map<String, int> totalCOVIDData = {};
  bool isWaiting = false;
  bool showSpinner = false;

  void getData() async {
    isWaiting = true;
    setState(() {
      showSpinner = true;
    });

    var data = await COVIDModel().getCOVIDData(widget.selectedCountry);

    isWaiting = false;

    setState(() {
      showSpinner = false;
    });

    setState(() {
      totalCOVIDData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.selectedCountry[0].toUpperCase() + widget.selectedCountry.substring(1)} COVID-19 Tracker'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Total Cases',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            '${isWaiting ? '?' : totalCOVIDData['cases']}',
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Total Deaths',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            '${isWaiting ? '?' : totalCOVIDData['deaths']}',
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Today Cases',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            '${isWaiting ? '?' : totalCOVIDData['todayCases']}',
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Today Deaths',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            '${isWaiting ? '?' : totalCOVIDData['todayDeaths']}',
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Total Recovered',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            '${isWaiting ? '?' : totalCOVIDData['recovered']}',
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Still Active',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            '${isWaiting ? '?' : totalCOVIDData['active']}',
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
