import 'dart:convert';
import 'dart:io';

import 'package:server/common/rest_request_handler.dart';
import 'package:server/features/users/entities/users_request.dart';
import 'package:server/features/users/entities/users_response.dart';

class UsersRestRequestHandler extends RestRequestHandler {
  @override
  Future<void> handleRequest(HttpRequest request) async {
    final bodyBytes = await request.toList();
    final bodyString = utf8.decode(bodyBytes.expand((x) => x).toList());

    UsersRequest usersRequest = UsersRequest.fromJson(json.decode(bodyString));

    final requestAcceptedAt = DateTime.now().microsecondsSinceEpoch.toString();

    final response = request.response;

    response.write(json.encode(UsersResponse(
      count: usersRequest.users.length,
      requestCreatedAt: usersRequest.requestCreatedAt,
      requestAcceptedAt: requestAcceptedAt,
      responseCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
    ).toJson()));
  }
}
