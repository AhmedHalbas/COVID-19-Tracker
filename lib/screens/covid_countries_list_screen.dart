import 'package:covid19/services/covid19.dart';
import 'package:covid19/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/reusable_card.dart';
import '../utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../components/internet_connection.dart';

class COVIDCountriesScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<COVIDCountriesScreen> {
  bool isWaiting = false;
  bool showSpinner = false;
  ScrollController controller;
  String COVIDAPIURL = 'https://coronavirus-19-api.herokuapp.com/countries';
  Covid19 covid19;
  List<Covid19> countriesList = [];
  var json;

  void getData() async {
    isWaiting = true;
    setState(() {
      showSpinner = true;
    });

    json = await NetworkHelper(COVIDAPIURL).getData();
    checkInternet(context, json);

    for (int i = 1; i < json.length; i++) {
      countriesList.add(Covid19.fromJson(json[i]));
    }

    isWaiting = false;

    setState(() {
      showSpinner = false;
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
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int position) => Divider(
                  color: Colors.white,
                ),
            itemCount: countriesList.length,
            itemBuilder: (context, position) {
              return ReusableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          countriesList[position].country,
                          style: kCountryNameTextStyle,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Total Cases: ${countriesList[position].cases} | Total Deaths: ${countriesList[position].deaths} | Today Cases: ${countriesList[position].todayCases} | Today Deaths: ${countriesList[position].todayDeaths} | Recovered: ${countriesList[position].recovered} | Active Cases: ${countriesList[position].active}',
                            style: kLabelTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
