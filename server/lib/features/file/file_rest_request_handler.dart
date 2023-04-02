import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:server/common/rest_request_handler.dart';
import 'package:server/features/file/entities/file_response.dart';

class FileRestRequestHandler extends RestRequestHandler {
  @override
  Future<void> handleRequest(HttpRequest request) async {
    final requestCreatedAt = request.uri.queryParameters["requestCreatedAt"];

    if (requestCreatedAt == null) {
      return;
    }

    final bytesLength = (await request.toList()).length;

    request.response.write(json.encode(FileResponse(
      size: bytesLength,
      requestCreatedAt: requestCreatedAt,
    ).toJson()));
  }
}
