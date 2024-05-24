import 'package:get/get.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class HomeController extends GetxController{
  
  RxString locationvalue = ''.obs;

  getAddress() async {
Location location = Location();
var currentLoc = await location.getLocation();

 GeoCode geoCode = GeoCode();
 Address address =
     await geoCode.reverseGeocoding(
      latitude: currentLoc.latitude!, 
      longitude: currentLoc.longitude!);
//  return "${address.streetAddress}, ${}, ${address.countryName}, ${address.postal}";

locationvalue('${address.streetAddress},${address.city}');
 
}
}