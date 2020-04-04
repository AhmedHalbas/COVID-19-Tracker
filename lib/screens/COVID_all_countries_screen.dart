import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/COVID.dart';
import '../components/reusable_card.dart';
import '../utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class COVIDCountriesScreen extends StatefulWidget {
  final String selectedCountry;
  List<String> countriesName = [];

  COVIDCountriesScreen(
      {@required this.selectedCountry, @required this.countriesName});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<COVIDCountriesScreen> {
  List<String> countriesList = [];
  bool isWaiting = false;
  bool showSpinner = false;
  bool _isVisible = true;
  ScrollController controller;

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
      countriesList = data;
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
                    Text(
                      widget.countriesName[position],
                      style: kCountryNameTextStyle,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            countriesList[position],
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
