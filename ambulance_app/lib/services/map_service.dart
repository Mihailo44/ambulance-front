import 'dart:convert';

import 'package:ambulance_app/config.dart';
import 'package:http/http.dart' as http;

class MapService {

  Future<String> getAddress({required double lat,required double lon}) async{
    
    final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$mapsAPIKey");
    
    var response = await http.get(url);

    if(response.statusCode == 200){
      var responseData = json.decode(response.body);
      String res = responseData["results"][0]["formatted_address"];
       
      return res ;
    }

    return "";
  }

}