import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mission_report_app/components/dialogs/custom_alert_dialog.dart';
import 'package:mission_report_app/components/default_image_widget.dart';
import 'package:mission_report_app/components/default_user_image_widget.dart';
import 'package:mission_report_app/components/loading_widget.dart';
import 'package:mission_report_app/components/textfields/outline_textfield.dart';
import 'package:mission_report_app/service/app_service/device_info_service.dart';
import 'package:mission_report_app/utils/color.dart';
import 'package:mission_report_app/utils/constant.dart';
import 'package:mission_report_app/utils/font.dart';
import 'package:mission_report_app/utils/string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as Path;

String? validateEmail(String value) {
  if (value.isEmpty) {
    return "empty_field".tr;
  }
  return (value.contains('@') && value.contains('.'))
      ? null
      : "enterValidEmail".tr;
}

String? validatePassword(String? value) {
  if (value == null) {
    return null;
  }
  if (value.isEmpty) {
    return "empty_field".tr;
  }
  return (value.length < 6) ? "enterMoreThan6Char".tr : null;
}

DateTime? currentBackPressTime;

Future<bool> onWillPop(BuildContext context) async {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    showSnackbar(context, "exit_app_message".tr);
    return Future.value(false);
  }
  return Future.value(true);
}

void showSnackbar(
  BuildContext context,
  String message, {
  SnackBarAction? action,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      action: action,
      margin: const EdgeInsets.all(8),
      padding: (action != null) ? null : const EdgeInsets.all(16),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      duration: duration ?? const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Future<void> showSimpleSnackbar(String message, {bool isForce = false}) async {
  if (isForce) {
    await Get.closeCurrentSnackbar();
  }

  Get.snackbar(
    "",
    "",
    titleText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: AppFonts.arial,
      ),
    ),
    messageText: const SizedBox(),
    margin: const EdgeInsets.all(8),
    snackStyle: SnackStyle.FLOATING,
    animationDuration: const Duration(milliseconds: 150),
    borderRadius: 4,
    backgroundColor: Colors.black,
    snackPosition: SnackPosition.BOTTOM,
  );
}

Future<void> showCustomDialog(
  context, {
  required String title,
  Function()? onCancel,
  Function()? onConfirm,
}) async {
  return showDialog<void>(
    context: context,
    useSafeArea: true,
    barrierDismissible: true,
    builder: (_) => CustomAlertDialog(
      title: title,
      onCancel: onCancel,
      onConfirm: onConfirm,
    ),
  );
}

bool dialogIsOpen = false;

Future<void> showRemoteConfigDialog(
  context, {
  required String title,
  required List<Widget> buttons,
}) async {
  if (dialogIsOpen) {
    Get.back(closeOverlays: true);
  }
  dialogIsOpen = true;

  return showDialog<void>(
    context: context,
    useSafeArea: true,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            width: double.infinity,
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: buttons,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void setStatusBarLight() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness:
          (GetPlatform.isIOS) ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          (GetPlatform.isIOS) ? Brightness.dark : Brightness.light,
    ),
  );
}

void setStatusBarDark() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness:
          (GetPlatform.isIOS) ? Brightness.light : Brightness.dark,
      statusBarBrightness:
          (GetPlatform.isIOS) ? Brightness.light : Brightness.dark,
    ),
  );
}

Future<void> delay({Duration? duration}) async {
  await Future.delayed(
    duration ?? const Duration(milliseconds: AppStaticValue.delayDuration),
  );
}

Future<dynamic> showAddTextFieldDialog(BuildContext context) async {
  final result = await showDialog(
    context: context,
    useSafeArea: true,
    barrierDismissible: true,
    builder: (context) {
      final textController = TextEditingController();

      return AlertDialog(
        title: Row(
          children: [
            Expanded(
              child: Text(
                "add_more".tr,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              splashColor: Colors.grey,
              icon: const Icon(
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        titlePadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStaticValue.cardBorderRadius),
        ),
        content: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlineTextField(
                label: "",
                controller: textController,
                minLines: 2,
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(result: textController.text);
            },
            child: Text("enter".tr),
          ),
        ],
      );
    },
  );
  return result;
}

Future<dynamic> showDescriptionTextFieldDialog(BuildContext context) async {
  final result = await showDialog(
    context: context,
    useSafeArea: true,
    barrierDismissible: true,
    builder: (context) {
      final textController = TextEditingController();

      return AlertDialog(
        title: Row(
          children: [
            Expanded(
              child: Text(
                "add_more_mission_description".tr,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              splashColor: Colors.grey,
              icon: const Icon(
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        titlePadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStaticValue.cardBorderRadius),
        ),
        content: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlineTextField(
                label: "mission_description".tr,
                controller: textController,
                minLines: 2,
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(result: textController.text);
            },
            child: Text("enter".tr),
          ),
        ],
      );
    },
  );
  return result;
}

int? checkDynamicId(dynamic data) {
  if (data == null) {
    return null;
  }
  if (data is int) {
    return data;
  }
  if (data is String) {
    if (data.isEmpty) {
      return null;
    }
    return int.parse(data);
  }
  return null;
}

String get basicAuth {
  String username = dotenv.env["USERNAME"] ?? "";
  String password = dotenv.env["PASSWORD"] ?? "";
  return "Basic ${base64.encode(utf8.encode('$username:$password'))}";
}

Future<File?> pickImageGallery() async {
  try {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image == null) return null;

    final imageTemp = File(image.path);
    log("imagePickedUrl: ${image.path}");

    return imageTemp;
  } on PlatformException catch (e) {
    log('Failed to pick image: $e');
  }
  return null;
}

Future<File?> pickImageCamera() async {
  try {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image == null) return null;

    final imageTemp = File(image.path);

    return imageTemp;
  } on PlatformException catch (e) {
    log('Failed to pick image: $e');
  }
  return null;
}

Future<List<File>> pickImagesGallery() async {
  try {
    final images = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );

    if (images.length == 0) return [];

    final imagesTemp = images.map((e) => File(e.path)).toList();

    return imagesTemp;
  } on PlatformException catch (e) {
    log('Failed to pick image: $e');
  }
  return [];
}

Future<void> requestUserLocationPermission() async {
  final status = await Permission.location.status;
  if (status.isGranted) {
    return;
  }

  final isAllow = await Permission.location.request();
  if (isAllow.isGranted) {
    return;
  }
}

void showLoadingDialog() {
  Get.dialog(
    const LoadingWidget(),
    transitionDuration: const Duration(milliseconds: 150),
  );
}

Widget? defaultProfileImageLoadState(state) {
  final loadState = state.extendedImageLoadState;
  if (loadState == LoadState.loading || loadState == LoadState.failed) {
    return const DefaultUserImageWidget();
  }
  return null;
}

Widget? defaultImageLoadState(state) {
  final loadState = state.extendedImageLoadState;
  if (loadState == LoadState.loading || loadState == LoadState.failed) {
    return const DefaultImageWidget();
  }
  return null;
}

Widget? defaultSquareImageLoadState(state) {
  final loadState = state.extendedImageLoadState;
  if (loadState == LoadState.loading || loadState == LoadState.failed) {
    return const DefaultImageWidget(
      shape: BoxShape.rectangle,
      fit: BoxFit.contain,
    );
  }
  return null;
}

int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
}

String getGender(String gender) {
  return (gender.toUpperCase() == "F") ? genders[1] : genders[0];
}

void focus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

Future<DateTimeRange?> pickDateRange(
  BuildContext context, {
  required DateTime startDate,
  required DateTime endDate,
}) async {
  return await showDateRangePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: AppStaticValue.now,
    locale: Get.locale,
    currentDate: AppStaticValue.now,
    initialDateRange: DateTimeRange(
      start: startDate,
      end: endDate,
    ),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                toolbarHeight: 100,
              ),
        ),
        child: child!,
      );
    },
  );
}

String get getAndroidDownload {
  // final appName = DeviceInfoService.appName;
  return "/storage/emulated/0/Download";
}

final cancelToken = CancelToken();

Future<String?> downloadPdfFile({
  required String url,
  required String fileName,
  Function(int count, int total, int percent)? onProgressUpdate,
}) async {
  final isAllow = await checkStoragePermission();
  if (!isAllow) {
    return null;
  }

  final dio = Dio();

  String dirPath = "";

  if (Platform.isAndroid) {
    dirPath = getAndroidDownload;
  } else {
    dirPath = (await getApplicationDocumentsDirectory()).path;
  }

  File file = File('$dirPath/$fileName');

  final isFileExist = await file.exists();

  if (isFileExist) {
    file = File('$dirPath/1_$fileName');
  }

  await file.create();

  try {
    final response = await dio.get(
      url,
      options: Options(responseType: ResponseType.bytes),
      cancelToken: cancelToken,
      onReceiveProgress: (count, total) {
        if (onProgressUpdate == null) {
          return;
        }
        onProgressUpdate(count, total, count * 100 ~/ total);
        // print("count: ${count * 100 / total}");
        // print("total: $total");
        // print("percent: ${(count * 100 / total).toStringAsFixed(2)}%");
      },
    );

    file.writeAsBytesSync(response.data);
    log("downloaded file: ${file.path}");
    if (response.statusCode == 200) {
      return file.path;
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}

Future<String?> viewPdfFile(String url) async {
  final isAllow = await checkStoragePermission();
  if (!isAllow) {
    return null;
  }

  String dirPath = "";

  if (Platform.isAndroid) {
    dirPath = getAndroidDownload;
  } else {
    dirPath = (await getApplicationDocumentsDirectory()).path;
  }

  final myUri = Uri.parse(url);
  final fileName = Path.basename(myUri.path);

  final file = File('$dirPath/$fileName');

  return file.path;
}

Future<bool> checkStoragePermission() async {
  if (Platform.isIOS) {
    return true;
  }

  if (Platform.isAndroid) {
    final int version = int.tryParse(DeviceInfoService.osVersion ?? "") ?? 0;
    if (version > 12) {
      return true;
    }
    final status = await Permission.storage.status;

    if (status == PermissionStatus.granted) {
      return true;
    }

    final result = await Permission.storage.request();
    return result == PermissionStatus.granted;
  }

  throw StateError('unknown platform');
}

Future<bool> checkFileIsDownloaded(String fileName) async {
  String dirPath = "";

  if (Platform.isAndroid) {
    dirPath = getAndroidDownload;
  } else {
    dirPath = (await getApplicationDocumentsDirectory()).path;
  }

  final file = File('$dirPath/$fileName');

  final isExist = await file.exists();

  return isExist;
}
