import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:superhero_app/models/success_response.dart';
import 'package:superhero_app/utils/functions.dart';

Future<dynamic> callingApiMethod({
  required String url,
  Object? body,
  required Method method,
  bool returnResponse = false,
  bool useBasicAuth = false,
  bool showError = true,
}) async {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";

  final uri = Uri.parse("$baseUrl$url");

  final Map<String, String> headers = {
    "Accept": "application/json",
    "content-type": "application/json",
  };

  if (kDebugMode) {
    log("url: $method $uri");
    log("body: $body");
    log("headers: $headers");
  }

  http.Response? response;
  try {
    switch (method) {
      case Method.POST:
        {
          response = await http.post(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
        }
        break;
      case Method.GET:
        {
          response = await http.get(
            uri,
            headers: headers,
          );
        }
        break;
      case Method.PUT:
        {
          response = await http.put(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
        }
        break;
      case Method.DELETE:
        {
          response = await http.delete(
            uri,
            headers: headers,
          );
        }
        break;
    }
  } catch (e) {
    log("callingApiMethodError: $e");
  }

  // Return unprocessed response
  if (returnResponse) {
    return response;
  }

  // Fail
  if (response == null) {
    log("response is null");
    return null;
  }

  //
  return processResponse(response, showError: showError);
}

dynamic processResponse(http.Response response, {bool showError = true}) {
  try {
    if (response.statusCode == 200) {
      final defaultResponse = successResponseFromJson(response.body);

      if (defaultResponse.statusCode != 200) {
        processError(defaultResponse.errorString(), showError: showError);
        return;
      }
      return defaultResponse;
    }
    processError(response, showError: showError);

    return null;
  } catch (e) {
    log("processResponseError: $e");
    log("response.body: ${response.body}");
  }
}

void processError(dynamic response, {bool showError = true}) {
  if (!kDebugMode) {
    if (!showError) {
      return;
    }
    showSnackbar(Get.context!, "default_fail_message".tr);
  } else {
    try {
      if (response is String) {
        showSnackbar(Get.context!, response);
        log("Message: $response");
      } else if (response is http.Response) {
        showSnackbar(Get.context!,
            "http.Response: Error Occurred : ${response.statusCode}");
        log("Status Code: ${response.statusCode}");
        log("http.Response ${response.body}");
      } else if (response is http.StreamedResponse) {
        showSnackbar(Get.context!,
            "http.StreamedResponse: Error Occurred : ${response.statusCode}");
        log("Status Code: ${response.statusCode}");
      } else {
        showSnackbar(Get.context!, "Unknown: Error Occurred");
        log("Unknown $response");
      }
    } catch (e) {
      log("processError: $e");
    }
  }
}

enum Method {
  POST,
  GET,
  PUT,
  DELETE,
}
