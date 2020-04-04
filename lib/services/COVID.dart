import 'networking.dart';
import '../utilities/constants.dart';

const COVIDAPIURL = 'https://coronavirus-19-api.herokuapp.com';

class COVIDModel {
  Future<dynamic> getCOVIDData(String selectedCountry) async {
    Map<String, int> totalCOVIDData = {};

    if (selectedCountry == 'all') {
      for (String requiredData in globalRequiredDataList) {
        NetworkHelper networkHelper = NetworkHelper('$COVIDAPIURL/all');

        var COVIDData = await networkHelper.getCOVIDData();

        totalCOVIDData[requiredData] = COVIDData[requiredData];
      }
      return totalCOVIDData;
    } else if (selectedCountry == 'countries') {
      List<String> countriesList = [];
      NetworkHelper networkHelper = NetworkHelper('$COVIDAPIURL/countries');
      var COVIDData = await networkHelper.getCOVIDData();
      for (int i = 1; i < COVIDData.length; i++) {
        for (String requiredData in countriesRequiredDataList) {
          totalCOVIDData[requiredData] = COVIDData[i][requiredData];
        }

        countriesList.add(totalCOVIDData
            .toString()
            .replaceAll(',', ' |')
            .replaceFirst('{', '')
            .replaceFirst('}', ''));
      }
      return countriesList;
    } else {
      for (String requiredData in countryRequiredDataList) {
        NetworkHelper networkHelper =
            NetworkHelper('$COVIDAPIURL/countries/$selectedCountry');

        var COVIDData = await networkHelper.getCOVIDData();

        totalCOVIDData[requiredData] = COVIDData[requiredData];
      }
      return totalCOVIDData;
    }
  }
}
