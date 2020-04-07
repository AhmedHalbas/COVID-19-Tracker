import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/covid19.dart';
import '../components/reusable_card.dart';
import '../utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import '../services/networking.dart';
import '../components/internet_connection.dart';

class COVIDGlobalScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<COVIDGlobalScreen> {
  bool isWaiting = false;
  bool showSpinner = false;
  final formatter = NumberFormat("#,###");
  var deathPercentage;
  String COVIDAPIURL = 'https://coronavirus-19-api.herokuapp.com/all';
  Covid19 covid19;
  var json;

  void getData() async {
    isWaiting = true;
    setState(() {
      showSpinner = true;
    });

    json = await NetworkHelper(COVIDAPIURL).getData();
    checkInternet(context, json);
    covid19 = Covid19.fromJson(json);

    isWaiting = false;

    setState(() {
      showSpinner = false;
    });

    setState(() {
      deathPercentage =
          ((covid19.deaths / covid19.cases) * 100).toStringAsFixed(2);
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      '${isWaiting ? '?' : formatter.format(covid19.cases)}',
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
                      '${isWaiting ? '?' : formatter.format(covid19.deaths)} ',
                      style: kNumberTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${isWaiting ? '?' : deathPercentage}%',
                      style: kLabelTextStyle,
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
                      'Total Recovered',
                      style: kLabelTextStyle,
                    ),
                    Text(
                      '${isWaiting ? '?' : formatter.format(covid19.recovered)}',
                      style: kNumberTextStyle,
                    ),
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
