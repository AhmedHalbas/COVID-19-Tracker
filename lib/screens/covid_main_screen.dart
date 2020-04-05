import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/alert_dialog.dart';
import '../screens/COVID_global_screen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../screens/covid_countries_list_screen.dart';
import '../screens/covid_search_country_screen.dart';

class MainScreen extends StatefulWidget {
  List<String> countries = [];
  MainScreen({this.countries});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<MainScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_index) {
      case 0:
        child = SearchScreen(
          countries: widget.countries,
        );
        break;
      case 1:
        child = COVIDGlobalScreen();
        break;
      case 2:
        child = COVIDCountriesScreen();
        break;
    }
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
                        'Emergency Call',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showAlertDialog(context,
                            isDismissible: true,
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
                PopupMenuItem(
                  child: Center(
                    child: GestureDetector(
                      child: Text(
                        'Important Advice',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showAlertDialog(context,
                            isDismissible: true,
                            title: 'World Health Organization Advice',
                            content: 'Some Advice For Public From WHO Website',
                            buttonText: 'Visit Now', onPressed: () {
                          Navigator.pop(context);
                          UrlLauncher.launch(
                              'https:who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public');
                        });
                      },
                    ),
                  ),
                ),
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
                            isDismissible: true,
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
              ];
            },
          )
        ],
        backgroundColor: Colors.black26,
        title: Text('COVID-19 Tracker'),
      ),
      body: SizedBox.expand(child: child),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        backgroundColor: Colors.black26,
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            title: Text("Global"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            title: Text("Countries"),
          ),
        ],
      ),
    );
  }
}
