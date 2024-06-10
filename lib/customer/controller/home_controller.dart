import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  RxString locationvalue = ''.obs;

  getAddress() async {
    Location location = Location();
    var currentLoc = await location.getLocation();

    GeoCode geoCode = GeoCode();
    Address address = await geoCode.reverseGeocoding(
        latitude: currentLoc.latitude!, longitude: currentLoc.longitude!);
//  return "${address.streetAddress}, ${}, ${address.countryName}, ${address.postal}";

    locationvalue('${address.streetAddress},${address.city}');
  }

  var entries = <int>[0].obs;
  var isCheck = false.obs;

  void addEntry() {
    entries.add(entries.length);
  }

  void removeEntry(int index) {
    if (entries.length > 1) {
      entries.removeAt(index);
    }
  }

  void toggleCheck(bool value) {
    isCheck.value = value;
  }

  var addParcels = <int>[0].obs;

  addParcelList() {
    addParcels.add(addParcels.length);
  }

  removeParcelList(index) {
    if (addParcels.length > 1) {
      addParcels.removeAt(index);
    }
  }

  var vehicalEntries = <int>[0].obs;
  var vehicalCheck = false.obs;

  roundCheck(bool value) {
    vehicalCheck.value = value;
  }

  addVehicalEntry() {
    vehicalEntries.add(vehicalEntries.length);
  }

  removeVehicalEntry(index) {
    if (vehicalEntries.length > 1) {
      vehicalEntries.removeAt(index);
    }
  }
}
