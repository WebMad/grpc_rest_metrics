import 'dart:convert';
import 'dart:io';

import 'package:server/common/rest_request_handler.dart';
import 'package:server/features/greeting/entities/greeting_request.dart';
import 'package:server/features/greeting/entities/greeting_response.dart';

class GreetingRestRequestHandler extends RestRequestHandler {
  @override
  Future<void> handleRequest(HttpRequest request) async {
    final bodyBytes = await request.toList();
    final bodyString = utf8.decode(bodyBytes.expand((x) => x).toList());

    final greetingRequest = GreetingRequest.fromJson(json.decode(bodyString));

    final response = request.response;

    response.write(json.encode(GreetingResponse(
      requestCreatedAt: greetingRequest.requestCreatedAt,
      greeting: "Hello, ${greetingRequest.name}",
    ).toJson()));
  }
}
