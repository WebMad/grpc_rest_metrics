part of 'greeting_rest_cubit.dart';

@freezed
class GreetingRestState with _$GreetingRestState {
  const factory GreetingRestState.initial() = _Initial;

  const factory GreetingRestState.processing() = _Processing;

  const factory GreetingRestState.error({
    required String msg,
  }) = _Error;

  const factory GreetingRestState.done({
    required List<TestCaseResult> testCaseResults,
  }) = _Done;
}
