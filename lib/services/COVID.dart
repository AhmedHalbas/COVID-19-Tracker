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
    } else {
      for (String requiredData in countriesRequiredDataList) {
        NetworkHelper networkHelper =
            NetworkHelper('$COVIDAPIURL/countries/$selectedCountry');

        var COVIDData = await networkHelper.getCOVIDData();

        totalCOVIDData[requiredData] = COVIDData[requiredData];
      }
    }

    return totalCOVIDData;
  }
}
