import 'package:flutter/material.dart';
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
  var receiverNameList = <String>[].obs;
  var receiverNumberList = <String>[].obs;
  var receiverBlockIdUnitIDs = '';
  var secondContainers = <int>[0].obs; // Initialize with one item

  void updateDroppingLocation(
      String location,
      String lat,
      String long,
      String arpincode,
      String bookingpincode,
      int index,
      String reciverName,
      String reciverNumber,
      String reciverBlockIdUnitID) {
    if (index < droppingLocations.length) {
      droppingLocations[index] = location;
      droppingLats[index] = lat;
      dropLongs[index] = long;
      pincodes[index] = arpincode;
      doornames[index] = bookingpincode;
      receiverNameList[index] = reciverName;
      receiverNumberList[index] = reciverNumber;
      receiverBlockIdUnitIDs = reciverBlockIdUnitID;
    } else {
      droppingLocations.add(location);
      droppingLats.add(lat);
      dropLongs.add(long);
      pincodes.add(arpincode);
      doornames.add(bookingpincode);
      receiverNameList.add(reciverName);
      receiverNumberList.add(reciverNumber);
      receiverBlockIdUnitIDs = reciverBlockIdUnitID;
    }
  }

////////////////////////////////////
  var vehicledroppingLocations = <String>[].obs;
  var vehicledroppingLats = <String>[].obs;
  var vehicledropLongs = <String>[].obs;
  var vehiclepincodes = <String>[].obs;
  var vehicledoornames = <String>[].obs;
  var vehicleentries = <int>[0].obs;
  var vehicleaddParcels = <int>[0].obs;
  var vehicleisCheck = false.obs;
  var vehiclereceiverNameList = <String>[].obs;
  var vehiclereceiverNumberList = <String>[].obs;
  var vehiclereceiverBlockIdUnitIDs = '';

  void vehicleDroppingLocation(
      String locationVehicle,
      String latVehicle,
      String longVehicle,
      String arpincodeVehicle,
      String bookingpincodeVehicle,
      int indexVehicle,
      String reciverNameVehicle,
      String reciverNumberVehicle,
      String reciverBlockIdUnitIDVehicle) {
    if (indexVehicle < vehicledroppingLocations.length) {
      vehicledroppingLocations[indexVehicle] = locationVehicle;
      vehicledroppingLats[indexVehicle] = latVehicle;
      vehicledropLongs[indexVehicle] = longVehicle;
      vehiclepincodes[indexVehicle] = arpincodeVehicle;
      vehicledoornames[indexVehicle] = bookingpincodeVehicle;
      vehiclereceiverNameList[indexVehicle] = reciverNameVehicle;
      vehiclereceiverNumberList[indexVehicle] = reciverNumberVehicle;
      vehiclereceiverBlockIdUnitIDs = reciverBlockIdUnitIDVehicle;
    } else {
      vehicledroppingLocations.add(locationVehicle);
      vehicledroppingLats.add(latVehicle);
      vehicledropLongs.add(longVehicle);
      vehiclepincodes.add(arpincodeVehicle);
      vehicledoornames.add(bookingpincodeVehicle);
      vehiclereceiverNameList.add(reciverNameVehicle);
      vehiclereceiverNumberList.add(reciverNumberVehicle);
      vehiclereceiverBlockIdUnitIDs = reciverBlockIdUnitIDVehicle;
    }
  }

  ////////////////////////
  var isRoundTripVisible = true.obs;

  void addEntry() {
    entries.add(entries.length);
    if (entries.length > 1) {
      isRoundTripVisible.value = false;
    }
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
    if (entries.length == 1) {
      isRoundTripVisible.value = true;
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

  var hideDeleteIcon = true.obs;

  bool isCheckedParcel = true;

  void setDeleteIconVisibility(bool value) {
    hideDeleteIcon.value = value;
  }

  // Lists of TextEditingController
  var parcelLengthControllers = <TextEditingController>[].obs;
  var parcelWidthControllers = <TextEditingController>[].obs;
  var parcelHeightControllers = <TextEditingController>[].obs;
  var parcelKgControllers = <TextEditingController>[].obs;
  var quantityControllers = <TextEditingController>[].obs;

  // Initialize TextEditingController for the first item
  HomeController() {
    parcelLengthControllers.add(TextEditingController());
    parcelWidthControllers.add(TextEditingController());
    parcelHeightControllers.add(TextEditingController());
    parcelKgControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
  }

//  var isChecklocationindex = true.obs;
  void addSecondContainer() {
    secondContainers.add(secondContainers.length);
    parcelLengthControllers.add(TextEditingController());
    parcelWidthControllers.add(TextEditingController());
    parcelHeightControllers.add(TextEditingController());
    parcelKgControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
  }

  void removeSecondContainer(int index) {
    if (secondContainers.length > 1) {
      secondContainers.removeAt(index);
      parcelLengthControllers[index].dispose();
      parcelWidthControllers[index].dispose();
      parcelHeightControllers[index].dispose();
      parcelKgControllers[index].dispose();
      quantityControllers[index].dispose();
      parcelLengthControllers.removeAt(index);
      parcelWidthControllers.removeAt(index);
      parcelHeightControllers.removeAt(index);
      parcelKgControllers.removeAt(index);
      quantityControllers.removeAt(index);
    }
  }

  var showYellowContainer = false.obs;

  void toggleYellowContainer() {
    showYellowContainer.value = !showYellowContainer.value;
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
