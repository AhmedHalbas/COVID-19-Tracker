import 'package:covid19/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/covid19.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import '../components/internet_connection.dart';
import '../components/covid_item.dart';

class COVIDCountryScreen extends StatefulWidget {
  final String selectedCountry;

  COVIDCountryScreen({@required this.selectedCountry});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<COVIDCountryScreen> {
  bool isWaiting = false;
  bool showSpinner = false;
  final formatter = NumberFormat("#,###");
  var deathPercentage;
  String COVIDAPIURL = 'https://coronavirus-19-api.herokuapp.com/countries/';
  Covid19 covid19;
  Text title;
  var json;

  void getData() async {
    isWaiting = true;
    setState(() {
      showSpinner = true;
    });

    json =
        await NetworkHelper('$COVIDAPIURL${widget.selectedCountry}').getData();

    checkInternet(context, json);

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
                  CovidItem(
                    itemText: 'Total Cases',
                    itemValue: covid19?.cases,
                    isWaiting: isWaiting,
                    formatter: formatter,
                  ),
                  CovidItem(
                    itemText: 'Total Deaths',
                    itemValue: covid19?.deaths,
                    isWaiting: isWaiting,
                    formatter: formatter,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  CovidItem(
                    itemText: 'Today Cases',
                    itemValue: covid19?.todayCases,
                    isWaiting: isWaiting,
                    formatter: formatter,
                  ),
                  CovidItem(
                    itemText: 'Today Deaths',
                    itemValue: covid19?.todayDeaths,
                    isWaiting: isWaiting,
                    formatter: formatter,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  CovidItem(
                    itemText: 'Total Recovered',
                    itemValue: covid19?.recovered,
                    isWaiting: isWaiting,
                    formatter: formatter,
                  ),
                  CovidItem(
                    itemText: 'Active Cases',
                    itemValue: covid19?.active,
                    isWaiting: isWaiting,
                    formatter: formatter,
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
