import 'dart:convert';
import 'dart:io';

import 'package:client/common/app_settings.dart';
import 'package:client/common/test_case_result.dart';
import 'package:client/features/users/entities/user.dart';
import 'package:client/features/users/entities/users_request.dart';
import 'package:client/features/users/entities/users_response.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_rest_cubit.freezed.dart';
part 'users_rest_state.dart';

class UsersRestCubit extends Cubit<UsersRestState> {
  UsersRestCubit() : super(const UsersRestState.initial());

  startMeasurement() async {
    try {
      emit(const UsersRestState.loadingUsers());
      final users = (await _loadUsers()).sublist(0, 100);

      emit(UsersRestState.processing(usersCount: users.length));

      final List<TestCaseResult> testCaseResults = [];
      for (var usersLength = 10;
          usersLength <= users.length;
          usersLength += 10) {
        final usersToSend = users.sublist(0, usersLength);

        for (var i = 0; i < 100; i++) {
          final result = await _sendRequest(usersToSend);
          testCaseResults.add(result);
        }
      }

      emit(UsersRestState.done(
        usersCount: users.length,
        testCaseResults: testCaseResults,
      ));
    } catch (e) {
      emit(UsersRestState.error(msg: e.toString()));
    }
  }

  Future<TestCaseResult> _sendRequest(List<User> users) async {
    final httpClient = HttpClient();

    final request = await httpClient.postUrl(
        Uri.parse("http://${AppSettings.host}:${AppSettings.restPort}/users"));

    final data = json.encode(UsersRequest(
      users: users,
      requestCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
    ).toJson());

    request.headers.contentType = ContentType.json;

    request.write(data);

    final response = await request.close();
    final requestVolume = data.length;
    final responseBody = await response.transform(utf8.decoder).join();
    final decodedResponse = UsersResponse.fromJson(json.decode(responseBody));

    final requestFinishedAt = DateTime.now().microsecondsSinceEpoch;

    final responseVolume = responseBody.length;

    return TestCaseResult(
      countRecords: decodedResponse.count,
      requestVolumeInBytes: requestVolume,
      responseVolumeInBytes: responseVolume,
      requestTime:
          requestFinishedAt - int.parse(decodedResponse.requestCreatedAt),
    );
  }

  Future<List<User>> _loadUsers() async {
    return (json.decode(await rootBundle.loadString("assets/users.json"))
            as List<dynamic>)
        .map((e) => User.fromJson(e))
        .toList();
  }
}
