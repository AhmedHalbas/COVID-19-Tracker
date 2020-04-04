import 'networking.dart';

const COVIDAPIURL = 'https://coronavirus-19-api.herokuapp.com';

class CountriesModel {
  Future<dynamic> getCountries() async {
    List<String> totalCountries = [];

    NetworkHelper networkHelper = NetworkHelper('$COVIDAPIURL/countries');

    var COVIDData = await networkHelper.getCOVIDData();

    for (var i = 1; i < COVIDData.length; i++) {
      totalCountries.add(COVIDData[i]['country']);
    }

    return totalCountries;
  }
}
