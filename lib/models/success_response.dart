import 'dart:convert';

import 'package:superhero_app/utils/functions.dart';


SuccessResponse successResponseFromJson(String str) =>
    SuccessResponse.fromJson(json.decode(str));

String successResponseToJson(SuccessResponse data) =>
    json.encode(data.toJson());

class SuccessResponse {
  SuccessResponse({
    this.statusCode,
    this.message,
    this.body,
  });

  int? statusCode;
  String? message;
  dynamic body;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      statusCode: checkDynamicId(json["status"]),
      message: json["message"],
      body: json["body"],
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "body": body,
      };

  String errorString() {
    String errorMessage = "";

    if (body is Map<String, dynamic>) {
      for (String key in body.keys) {
        final message = body[key] ?? "";
        if (message is List<dynamic> && message.isNotEmpty) {
          errorMessage += "${message[0]}";
        } else {
          errorMessage += "$message";
        }
      }
    } else {
      Map<String, List<dynamic>> bodyErrorMessage = Map.from(body);

      for (String key in bodyErrorMessage.keys) {
        final message = bodyErrorMessage[key]?[0] ?? "";
        if (message.isNotEmpty) {
          errorMessage += "$message";
        }
      }
    }

    return errorMessage;
  }

  Map<String, dynamic> get bodyObject {
    return Map.from(body);
  }

  List<dynamic> get bodyArray {
    return body;
  }

  @override
  String toString() {
    return 'SuccessResponse{statusCode: $statusCode, message: $message, body: $body}';
  }
}
