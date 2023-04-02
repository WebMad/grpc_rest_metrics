part of 'file_rest_cubit.dart';

@freezed
class FileRestState with _$FileRestState {
  const factory FileRestState.initial() = _Initial;

  const factory FileRestState.processing() = _Processing;

  const factory FileRestState.error({
    required String msg,
  }) = _Error;

  const factory FileRestState.done({
    required List<TestCaseResult> testCaseResults,
  }) = _Done;
}
