import '../screens/COVID_country_screen.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../components/alert_dialog.dart';
import '../screens/COVID_global_screen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class InputScreen extends StatefulWidget {
  List<String> countries = [];
  InputScreen({this.countries});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String selectedCountry;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Center(
                    child: GestureDetector(
                      child: Text(
                        'About',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showAlertDialog(context,
                            title: 'About Developer',
                            content:
                                'Developed By Ahmed Halbas \n\n #Stay_Home',
                            buttonText: 'Ok', onPressed: () {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: Center(
                    child: GestureDetector(
                      child: Text(
                        'Emergency Call',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showAlertDialog(context,
                            title: 'Egyptian Preventive Emergency Line',
                            content: 'Call 105 For Inquiries',
                            buttonText: 'Call Now', onPressed: () {
                          Navigator.pop(context);
                          UrlLauncher.launch('tel:105');
                        });
                      },
                    ),
                  ),
                ),
              ];
            },
          )
        ],
        backgroundColor: Colors.black26,
        title: Text('COVID-19 Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'images/covid_19_icon.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            SimpleAutoCompleteTextField(
              controller: _controller,
              key: key,
              suggestions: widget.countries,
              clearOnSubmit: false,
              textSubmitted: (text) => setState(() {
                selectedCountry = text;
              }),
              decoration: InputDecoration(
                filled: true,
                hintText: 'Enter Country Name',
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            RoundedButton(
              color: Colors.blueAccent,
              title: 'Search',
              onPressed: () {
                if (selectedCountry == null) {
                  showAlertDialog(context,
                      title: 'Country Name Issue',
                      content: 'Please Enter Your Country Name Properly',
                      buttonText: 'Ok', onPressed: () {
                    Navigator.pop(context);
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => COVIDCountryScreen(
                        selectedCountry: selectedCountry,
                      ),
                    ),
                  ).then(
                    (_) => {
                      selectedCountry = null,
                      _controller.clear(),
                    },
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: GestureDetector(
                child: Text(
                  'Global Cases Page',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => COVIDGlobalScreen(
                        selectedCountry: 'all',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
