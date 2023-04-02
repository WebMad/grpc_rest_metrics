part of 'file_grpc_cubit.dart';

@freezed
class FileGrpcState with _$FileGrpcState {
  const factory FileGrpcState.initial() = _Initial;

  const factory FileGrpcState.processing() = _Processing;

  const factory FileGrpcState.error({
    required String msg,
  }) = _Error;

  const factory FileGrpcState.done({
    required List<TestCaseResult> testCaseResults,
  }) = _Done;
}
