import '../screens/covid_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import '../components/alert_dialog.dart';
import '../services/firebase_notification_handler.dart';
import '../services/networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<String> countries = [];
  bool _noInternet = true;
  String COVIDAPIURL = 'https://coronavirus-19-api.herokuapp.com/countries';

  void getCountries() async {
    var json = await NetworkHelper(COVIDAPIURL).getData();

    for (int i = 1; i < json.length; i++) {
      countries.add(json[i]['country'].toString());
    }

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
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
        isDismissible: false,
        title: 'Internet Connection Issue',
        content: 'Please Enable Your Network Data',
        buttonText: 'Ok',
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
    FirebaseNotifications().setUpFirebase();
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
