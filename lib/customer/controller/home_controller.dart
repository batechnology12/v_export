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

//// pickup location

  var pickupLocation = ''.obs;
  var pickuplatitude = ''.obs;
  var pickuplongitude = ''.obs;
  var pickupSenderName = ''.obs;
  var pickupSenderNumber = ''.obs;
  var pickupblockUnitId = ''.obs;

  updatepickupLocation(
    String pickuplocation,
    String pickuplat,
    String pickuplong,
    String senderName,
    String senderNumber,
    String pickupunitId
  ) {
    pickupLocation.value = pickuplocation;
    pickuplatitude.value = pickuplat;
    pickuplongitude.value = pickuplong;
    pickupSenderName.value = senderName;
    pickupSenderNumber.value = senderNumber;
    pickupblockUnitId.value = pickupunitId;
  }

  //// dropping location
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

  // //////

  // List<String> getLengths() {
  //   List<String> lengths = [];
  //   for (var location in locationData) {
  //     for (var item in location.values.first) {
  //       lengths.add(item['length']?.text ?? '');
  //     }
  //   }
  //   return lengths;
  // }

  // List<String> getWidths() {
  //   List<String> widths = [];
  //   for (var location in locationData) {
  //     for (var item in location.values.first) {
  //       widths.add(item['width']?.text ?? '');
  //     }
  //   }
  //   return widths;
  // }

  // List<String> getHeights() {
  //   List<String> heights = [];
  //   for (var location in locationData) {
  //     for (var item in location.values.first) {
  //       heights.add(item['height']?.text ?? '');
  //     }
  //   }
  //   return heights;
  // }

  // List<String> getQuantities() {
  //   List<String> quantities = [];
  //   for (var location in locationData) {
  //     for (var item in location.values.first) {
  //       quantities.add(item['qty']?.text ?? '');
  //     }
  //   }
  //   return quantities;
  // }

  // List<String> getWeights() {
  //   List<String> weights = [];
  //   for (var location in locationData) {
  //     for (var item in location.values.first) {
  //       weights.add(item['kg']?.text ?? '');
  //     }
  //   }
  //   return weights;
  // }
/////////

  // var locationData =
  //     <Map<String, List<Map<String, TextEditingController>>>>[].obs;
  // @override
  // void onInit() {
  //   super.onInit();
  //   // Initialize with one location
  //   addLocation();
  // }

  // void addLocation() {
  //   locationData.add({
  //     'Location': [
  //       {
  //         'length': TextEditingController(),
  //         'width': TextEditingController(),
  //         'height': TextEditingController(),
  //         'kg': TextEditingController(),
  //         'qty': TextEditingController(),
  //       }
  //     ]
  //   });
  // }

  // void printDimensions(int locationIndex, int itemIndex) {
  //   if (locationIndex < locationData.length) {
  //     var location = locationData[locationIndex];
  //     if (location.isNotEmpty && itemIndex < location.values.first.length) {
  //       var item = location.values.first[itemIndex];

  //       print('Length: ${item['length']?.text}');
  //       print('Width: ${item['width']?.text}');
  //       print('Height: ${item['height']?.text}');
  //     } else {
  //       print('Item index out of range.');
  //     }
  //   } else {
  //     print('Location index out of range.');
  //   }
  // }

  // void addItem(int locationIndex) {
  //   if (locationIndex < locationData.length) {
  //     locationData[locationIndex].values.first.add({
  //       'length': TextEditingController(),
  //       'width': TextEditingController(),
  //       'height': TextEditingController(),
  //       'kg': TextEditingController(),
  //       'qty': TextEditingController(),
  //     });
  //     update(); // Notify listeners
  //   }
  // }

  // void deleteItem(int locationIndex, int itemIndex) {
  //   if (locationIndex < locationData.length) {
  //     var items = locationData[locationIndex].values.first;
  //     if (itemIndex < items.length) {
  //       // Prevent deletion if item is at index 0
  //       if (itemIndex == 0) {
  //         print('Cannot delete item at index 0');
  //         return;
  //       }

  //       // Dispose of TextEditingControllers before removing the item
  //       items[itemIndex]['length']?.dispose();
  //       items[itemIndex]['width']?.dispose();
  //       items[itemIndex]['height']?.dispose();
  //       items[itemIndex]['kg']?.dispose();
  //       items[itemIndex]['qty']?.dispose();

  //       // Remove the item at itemIndex
  //       items.removeAt(itemIndex);

  //       // If the list is empty, delete the location
  //       if (items.isEmpty) {
  //         deleteLocation(locationIndex);
  //       } else {
  //         update(); // Notify listeners
  //       }
  //     } else {
  //       // Handle case where itemIndex is out of bounds
  //       print('Item index out of bounds');
  //     }
  //   } else {
  //     // Handle case where locationIndex is out of bounds
  //     print('Location index out of bounds');
  //   }
  // }

  // void deleteLocation(int locationIndex) {
  //   if (locationIndex < locationData.length) {
  //     var items = locationData[locationIndex].values.first;
  //     items.forEach((item) {
  //       item['length']?.dispose();
  //       item['width']?.dispose();
  //       item['height']?.dispose();
  //       item['kg']?.dispose();
  //       item['qty']?.dispose();
  //     });
  //     locationData.removeAt(locationIndex);
  //     update(); // Notify listeners
  //   }
  // }

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

  bool isCheckedLocation = false;

  void addParcelList() {
    addParcels.add(addParcels.length);
    if (addParcels.length > 1) {
      isCheckedLocation = true;
    }
  }

  void removeParcelList(int index) {
    if (addParcels.length > 1) {
      addParcels.removeAt(index);
    }

    if (addParcels.length <= 1) {
      isCheckedLocation = false;
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

  void addController() {
    var controller = TextEditingController();
    parcelKgControllers.add(controller);
  }

  void removeController(int index) {
    parcelKgControllers[index].dispose();
    parcelKgControllers.removeAt(index);
  }

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
