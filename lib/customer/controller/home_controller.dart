import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geocode/geocode.dart';
// import 'package:location/location.dart' as loc;

class HomeController extends GetxController {
//   getAddress() async {
//     late loc.Location location = Location();
//     var currentLoc = await location.getLocation();

//     GeoCode geoCode = GeoCode();
//     Address address = await geoCode.reverseGeocoding(
//         latitude: currentLoc.latitude!, longitude: currentLoc.longitude!);
// //  return "${address.streetAddress}, ${}, ${address.countryName}, ${address.postal}";

//     locationvalue('${address.streetAddress},${address.city}');
//   }

  var droppingLocations = <String>[].obs;
  var droppingLats = <String>[].obs;
  var dropLongs = <String>[].obs;
  var pincodes = <String>[].obs;
  var doornames = <String>[].obs;
  var entries = <int>[0].obs;
  var addParcels = <int>[0].obs;
  var isCheck = false.obs;

  void updateDroppingLocation(String location, String lat, String long,
      String arpincode, String bookingpincode, int index) {
    if (index < droppingLocations.length) {
      droppingLocations[index] = location;
      droppingLats[index] = lat;
      dropLongs[index] = long;
      pincodes[index] = arpincode;
      doornames[index] = bookingpincode;
    } else {
      droppingLocations.add(location);
      droppingLats.add(lat);
      dropLongs.add(long);
      pincodes.add(arpincode);
      doornames.add(bookingpincode);
    }
  }

  void addEntry() {
    entries.add(entries.length);
  }

  void removeEntry(int index) {
    if (entries.length > 1) {
      entries.removeAt(index);
      if (index < droppingLocations.length) {
        droppingLocations.removeAt(index);
        droppingLats.removeAt(index);
        dropLongs.removeAt(index);
        pincodes.removeAt(index);
        doornames.removeAt(index);
      }
    }
  }

  void addParcelList() {
    addParcels.add(addParcels.length);
  }

  void removeParcelList(int index) {
    if (addParcels.length > 1) {
      addParcels.removeAt(index);
    }
  }

  void toggleCheck(bool value) {
    isCheck.value = value;
  }

  // var entries = <int>[0].obs;
  // var isCheck = false.obs;
  // void addEntry() {
  //   entries.add(entries.length);
  // }

  // void removeEntry(int index) {
  //   if (entries.length > 1) {
  //     entries.removeAt(index);
  //     if (index < droppingLocations.length) {
  //       droppingLocations.removeAt(index);
  //     }
  //   }
  // }

  // void toggleCheck(bool value) {
  //   isCheck.value = value;
  // }

  // List<String> droppingLocations = <String>[].obs;

  // String droppingLat = "";
  // String dropLong = "";
  // String pincode = "";
  // String doorname = "";

  // void updateDroppingLocation(String location, String lat, String long,
  //     String arpincode, String bookingpincode) {
  //   // if (index < droppingLocations.length) {
  //   droppingLocations.add(location);
  //   droppingLat = lat;
  //   dropLong = long;
  //   pincode = arpincode;
  //   doorname = bookingpincode;
  // }

  // var addParcels = <int>[0].obs;

  // addParcelList() {
  //   addParcels.add(addParcels.length);
  // }

  // removeParcelList(index) {
  //   if (addParcels.length > 1) {
  //     addParcels.removeAt(index);
  //   }
  // }

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
