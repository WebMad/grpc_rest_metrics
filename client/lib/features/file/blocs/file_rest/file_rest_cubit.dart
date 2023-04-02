import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:client/common/app_settings.dart';
import 'package:client/common/test_case_result.dart';
import 'package:client/features/file/entities/file_response.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_rest_cubit.freezed.dart';
part 'file_rest_state.dart';

class FileRestCubit extends Cubit<FileRestState> {
  FileRestCubit() : super(const FileRestState.initial());

  startMeasurement() async {
    try {
      emit(const FileRestState.processing());

      final List<TestCaseResult> testCaseResults = [];

      final file2mb = await rootBundle.load("assets/2mb.png");
      final bytes2mb = Uint8List.view(file2mb.buffer);

      for (int i = 0; i < 100; i++) {
        testCaseResults.add(await _createRequest(bytes2mb));
      }

      final file10mb = await rootBundle.load("assets/10mb.png");
      final bytes10mb = Uint8List.view(file10mb.buffer);

      for (int i = 0; i < 100; i++) {
        testCaseResults.add(await _createRequest(bytes10mb));
      }

      emit(FileRestState.done(testCaseResults: testCaseResults));
    } catch (e) {
      emit(FileRestState.error(msg: e.toString()));
    }
  }

  Future<TestCaseResult> _createRequest(Uint8List bytes) async {
    final httpClient = HttpClient();

    final request = await httpClient.postUrl(Uri.parse(
        "http://${AppSettings.host}:${AppSettings.restPort}/file?requestCreatedAt=${DateTime.now().microsecondsSinceEpoch}"));

    request.headers.contentType = ContentType.json;

    request.write(bytes);

    final response = await request.close();
    final requestVolume = bytes.length;
    final responseBody = await response.transform(utf8.decoder).join();
    final decodedResponse = FileResponse.fromJson(json.decode(responseBody));
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
