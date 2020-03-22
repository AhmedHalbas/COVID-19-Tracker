import 'package:covid19/screens/input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/countries_list.dart';
import 'dart:io';
import '../components/alert_dialog.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<String> countries = [];
  bool _noInternet = true;

  void getCountries() async {
    countries = await CountriesModel().getCountries();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return InputScreen(
        countries: countries,
      );
    }), (_) => false);
  }

  void checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _noInternet = false;
        getCountries();
      }
    } on SocketException catch (_) {
      return showAlertDialog(
        context,
        title: 'Internet Connection Issue',
        content: 'Please Enable Your Network Data',
        onPressed: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 70,
        ),
      ),
    );
  }
}
