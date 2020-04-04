import 'package:flutter/material.dart';

const List<String> countryRequiredDataList = [
  'cases',
  'todayCases',
  'deaths',
  'todayDeaths',
  'recovered',
  'active',
];

const List<String> countriesRequiredDataList = [
  'cases',
  'todayCases',
  'deaths',
  'todayDeaths',
  'recovered',
];

const List<String> globalRequiredDataList = [
  'cases',
  'todayCases',
  'deaths',
  'todayDeaths',
  'recovered',
  'active',
];

const kActiveCardColour = Color(0XFF1D1E33);

const kLabelTextStyle = TextStyle(
  fontSize: 18,
  color: Color(0XFF8D8E98),
);

const kNumberTextStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w900,
);

const kCountryNameTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w900,
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
