import 'package:freezed_annotation/freezed_annotation.dart';

part 'greeting_request.freezed.dart';
part 'greeting_request.g.dart';

@freezed
class GreetingRequest with _$GreetingRequest {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory GreetingRequest({
    required String name,
    required String requestCreatedAt,
  }) = _GreetingRequest;

  factory GreetingRequest.fromJson(Map<String, dynamic> json) =>
      _$GreetingRequestFromJson(json);
}
