import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_case_result.freezed.dart';
part 'test_case_result.g.dart';

@freezed
class TestCaseResult with _$TestCaseResult {
  const factory TestCaseResult({
    required int countRecords,
    required int requestVolumeInBytes,
    required int responseVolumeInBytes,
    required int requestTime,
    required int responseTime,
  }) = _TestCaseResult;

  factory TestCaseResult.fromJson(Map<String, dynamic> json) =>
      _$TestCaseResultFromJson(json);
}
