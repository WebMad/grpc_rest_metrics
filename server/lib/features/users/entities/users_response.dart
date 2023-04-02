import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_response.freezed.dart';
part 'users_response.g.dart';

@freezed
class UsersResponse with _$UsersResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory UsersResponse({
    required int count,
    required String requestCreatedAt,
  }) = _UsersResponse;

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);
}
