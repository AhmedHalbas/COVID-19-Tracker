import 'package:covid19/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/covid19.dart';
import '../components/reusable_card.dart';
import '../utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';

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
  final formatter = NumberFormat("#,###");
  var deathPercentage;
  String COVIDAPIURL = 'https://coronavirus-19-api.herokuapp.com/countries/';
  Covid19 covid19;
  Text title;

  void getData() async {
    isWaiting = true;
    setState(() {
      showSpinner = true;
    });

    var json =
        await NetworkHelper('$COVIDAPIURL${widget.selectedCountry}').getData();
    covid19 = Covid19.fromJson(json);

    isWaiting = false;

    setState(() {
      showSpinner = false;
    });

    setState(() {
      deathPercentage =
          ((covid19.deaths / covid19.cases) * 100).toStringAsFixed(2);

      title = Text('${covid19.country} COVID-19 Tracker');
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
        title: title,
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${isWaiting ? '?' : formatter.format(covid19.cases)}',
                                style: kNumberTextStyle,
                              ),
                            ),
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${isWaiting ? '?' : formatter.format(covid19.deaths)}',
                                style: kNumberTextStyle,
                              ),
                            ),
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${isWaiting ? '?' : formatter.format(covid19.todayCases)}',
                                style: kNumberTextStyle,
                              ),
                            ),
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${isWaiting ? '?' : formatter.format(covid19.todayDeaths)}',
                                style: kNumberTextStyle,
                              ),
                            ),
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${isWaiting ? '?' : formatter.format(covid19.recovered)}',
                                style: kNumberTextStyle,
                              ),
                            ),
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
                            'Active Cases',
                            style: kLabelTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${isWaiting ? '?' : formatter.format(covid19.active)}',
                                style: kNumberTextStyle,
                              ),
                            ),
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
