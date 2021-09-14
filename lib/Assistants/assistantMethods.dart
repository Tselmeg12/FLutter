import 'package:flutteruber/Assistants/requestAssistant.dart';
import 'package:flutteruber/DataHandler/appData.dart';
import 'package:flutteruber/Models/address.dart';
import 'package:flutteruber/configMaps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AssistantMethods

{
  static Future<String> searchCoordinateAddress( Position position, context) async
  {

    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${mapKey}";


    var response = await RequestAssistant.getRequest(url);

    if(response != "failed")
      {
        st1 = response["results"][0]["address_components"][0]["long_name"];

        st2 = response["results"][0]["address_components"][1]["long_name"];

        st3 = response["results"][0]["address_components"][5]["long_name"];

        st4 = response["results"][0]["address_components"][6]["long_name"];

        placeAddress = st1 +", "+ st2 + ", " +st3+", "+st4;

        placeAddress = response["results"][0]["address_components"][3]["long_name"];

      }
    return placeAddress;
  }
}