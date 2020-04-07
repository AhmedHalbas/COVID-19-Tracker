import '../screens/covid_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/firebase_notification_handler.dart';
import '../services/networking.dart';
import '../components/internet_connection.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<String> countries = [];
  String COVIDAPIURL = 'https://coronavirus-19-api.herokuapp.com/countries';
  var json;

  void getCountries() async {
    json = await NetworkHelper(COVIDAPIURL).getData();

    checkInternet(context, json);

    for (int i = 1; i < json.length; i++) {
      countries.add(json[i]['country'].toString());
    }

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        countries: countries,
      );
    }), (_) => false);
  }

  @override
  void initState() {
    super.initState();
    getCountries();
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
