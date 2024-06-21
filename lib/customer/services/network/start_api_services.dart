import 'package:get/get.dart';
import 'package:v_export/constant/app_constant.dart';
import 'package:v_export/customer/services/network/network_confg.dart';
import 'package:v_export/customer/services/network/storage_repository.dart';

class StartupServices {
  static NetworkProvider? networkProvider;
  static String? entryMode;
  static int? stageKey;
  static String? mobileKey;
  static String? name;
  static String? token;
  static String? id;
  static String? profileImage;

  Future<bool> init() async {
    token =
        await StorageRepository.getOfflineKey(AppConstant.authToken) ?? "N/A";
    // id = await StorageRepository.getOfflineKey(
    //         AppConstant.offlineidStorageKey) ??
    //     "N/A";
    networkProvider = await Get.put(NetworkProvider());
    // stageKey = int.tryParse(await StorageRepository.getOfflineKey(
    //             AppConstant.startUpModeStageKey) ??
    //         "") ??
    // AppConstant.getStartedStageValue;
    // entryMode = await StorageRepository.getOfflineKey(
    //         AppConstant.startUpModeStoreKey) ??
    //     AppConstant.initialMode;
    // mobileKey = await StorageRepository.getOfflineKey(
    //     AppConstant.offlineMobileStorageKey);
    // name = await StorageRepository.getOfflineKey(
    //         AppConstant.offlineNameStorageKey) ??
    //     "N/A";
    // profileImage = await StorageRepository.getOfflineKey(
    //         AppConstant.offlineProfileImageKey) ??
    //     "N/A";
    //token = await StorageRepository.getOfflineKey(AppConstant.offlineTokenStorageKey) ?? "N/A" ;
    Get.log("Token Key :::: ${token}");
    // Get.log(
    //     "Entry Mode :::: ${entryMode} \n Stage Mode :::: ${stageKey} \n Mobile Key :::: ${mobileKey} \n Name Key :::: ${name} \n Token Key :::: ${token} id::::::${id}");
    // Get.log(id!);
    return true;
  }
}
