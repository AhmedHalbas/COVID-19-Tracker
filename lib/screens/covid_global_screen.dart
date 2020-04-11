import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/covid19.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import '../services/networking.dart';
import '../components/internet_connection.dart';
import '../components/covid_item.dart';

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
              deathPercentage: deathPercentage,
            ),
            CovidItem(
              itemText: 'Total Recovered',
              itemValue: covid19?.recovered,
              isWaiting: isWaiting,
              formatter: formatter,
            ),
          ],
        ),
      ),
    );
  }
}
