import 'package:freezed_annotation/freezed_annotation.dart';

part 'greeting_response.freezed.dart';
part 'greeting_response.g.dart';

@freezed
class GreetingResponse with _$GreetingResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory GreetingResponse({
    required String greeting,
    required String requestCreatedAt,
  }) = _GreetingResponse;

  factory GreetingResponse.fromJson(Map<String, dynamic> json) =>
      _$GreetingResponseFromJson(json);
}
