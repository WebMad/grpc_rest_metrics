import 'dart:typed_data';

import 'package:client/common/app_settings.dart';
import 'package:client/common/test_case_result.dart';
import 'package:client/features/file/protos/file.pbgrpc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grpc/grpc.dart';

part 'file_grpc_cubit.freezed.dart';
part 'file_grpc_state.dart';

class FileGrpcCubit extends Cubit<FileGrpcState> {
  FileGrpcCubit() : super(const FileGrpcState.initial());

  startMeasurement() async {
    try {
      emit(const FileGrpcState.processing());
      final channel = ClientChannel(
        AppSettings.host,
        port: AppSettings.grpcPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );

      final greetingServiceClient = FileServiceClient(channel);

      final List<TestCaseResult> testCaseResults = [];
      final file2mb = await rootBundle.load("assets/2mb.png");
      final bytes2mb = Uint8List.view(file2mb.buffer);

      for (int i = 0; i < 100; i++) {
        testCaseResults
            .add(await _createRequest(greetingServiceClient, bytes2mb));
      }

      final file10mb = await rootBundle.load("assets/10mb.png");
      final bytes10mb = Uint8List.view(file10mb.buffer);

      for (int i = 0; i < 100; i++) {
        testCaseResults
            .add(await _createRequest(greetingServiceClient, bytes10mb));
      }

      await channel.shutdown();

      emit(FileGrpcState.done(testCaseResults: testCaseResults));
    } catch (e) {
      emit(FileGrpcState.error(msg: e.toString()));
    }
  }

  Future<TestCaseResult> _createRequest(
    FileServiceClient fileServiceClient,
    Uint8List bytes,
  ) async {
    final data = FileRequest(
      file: bytes,
      requestCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
    );

    final response = await fileServiceClient.file(data);
    final requestFinishedAt = DateTime.now().microsecondsSinceEpoch;

    final requestVolume = data.writeToBuffer().length;

    final responseVolume = response.writeToBuffer().length;

    return TestCaseResult(
      countRecords: 1,
      requestVolumeInBytes: requestVolume,
      responseVolumeInBytes: responseVolume,
      requestTime: requestFinishedAt - int.parse(response.requestCreatedAt),
    );
  }
}
