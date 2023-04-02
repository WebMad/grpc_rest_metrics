part of 'greeting_grpc_cubit.dart';

@freezed
class GreetingGrpcState with _$GreetingGrpcState {
  const factory GreetingGrpcState.initial() = _Initial;

  const factory GreetingGrpcState.processing() = _Processing;

  const factory GreetingGrpcState.error({
    required String msg,
  }) = _Error;

  const factory GreetingGrpcState.done({
    required List<TestCaseResult> testCaseResults,
  }) = _Done;
}
