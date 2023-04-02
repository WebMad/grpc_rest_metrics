import 'dart:convert';
import 'dart:io';

import 'package:client/common/app_settings.dart';
import 'package:client/common/test_case_result.dart';
import 'package:client/features/greeting/entities/greeting_request.dart';
import 'package:client/features/greeting/entities/greeting_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'greeting_rest_cubit.freezed.dart';
part 'greeting_rest_state.dart';

class GreetingRestCubit extends Cubit<GreetingRestState> {
  GreetingRestCubit() : super(const GreetingRestState.initial());

  startMeasurement() async {
    try {
      emit(const GreetingRestState.processing());

      final List<TestCaseResult> testCaseResults = [];

      for (int i = 0; i < 100; i++) {
        testCaseResults.add(await _createRequest());
      }

      emit(GreetingRestState.done(testCaseResults: testCaseResults));
    } catch (e, ee) {
      print(e);
      print(ee);
      emit(GreetingRestState.error(msg: e.toString()));
    }
  }

  Future<TestCaseResult> _createRequest() async {
    final httpClient = HttpClient();

    final request = await httpClient.postUrl(Uri.parse(
        "http://${AppSettings.host}:${AppSettings.restPort}/greeting"));

    final data = json.encode(GreetingRequest(
      name: 'Alice',
      requestCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
    ).toJson());

    request.headers.contentType = ContentType.json;

    request.write(data);

    final response = await request.close();
    final requestVolume = data.length;
    final responseBody = await response.transform(utf8.decoder).join();
    final decodedResponse =
        GreetingResponse.fromJson(json.decode(responseBody));
    final requestFinishedAt = DateTime.now().microsecondsSinceEpoch;

    final responseVolume = responseBody.length;

    return TestCaseResult(
      countRecords: 1,
      requestVolumeInBytes: requestVolume,
      responseVolumeInBytes: responseVolume,
      requestTime:
          requestFinishedAt - int.parse(decodedResponse.requestCreatedAt),
    );
  }
}
