import 'package:client/common/app_settings.dart';
import 'package:client/common/test_case_result.dart';
import 'package:client/features/greeting/protos/greeting.pbgrpc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grpc/grpc.dart';

part 'greeting_grpc_cubit.freezed.dart';
part 'greeting_grpc_state.dart';

class GreetingGrpcCubit extends Cubit<GreetingGrpcState> {
  GreetingGrpcCubit() : super(const GreetingGrpcState.initial());

  startMeasurement() async {
    try {
      emit(const GreetingGrpcState.processing());
      final channel = ClientChannel(
        AppSettings.host,
        port: AppSettings.grpcPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );

      final greetingServiceClient = GreetingServiceClient(channel);

      final List<TestCaseResult> testCaseResults = [];

      for (int i = 0; i < 100; i++) {
        testCaseResults.add(await _createRequest(greetingServiceClient));
      }

      await channel.shutdown();

      emit(GreetingGrpcState.done(testCaseResults: testCaseResults));
    } catch (e) {
      emit(GreetingGrpcState.error(msg: e.toString()));
    }
  }

  Future<TestCaseResult> _createRequest(
    GreetingServiceClient greetingServiceClient,
  ) async {
    final data = GreetingRequest(
      name: "Alice",
      requestCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
    );

    final response = await greetingServiceClient.greeting(data);
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
