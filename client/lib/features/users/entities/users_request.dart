import 'package:client/features/users/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_request.freezed.dart';
part 'users_request.g.dart';

@freezed
class UsersRequest with _$UsersRequest {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory UsersRequest({
    required List<User> users,
    required String requestCreatedAt,
  }) = _UsersRequest;

  factory UsersRequest.fromJson(Map<String, dynamic> json) =>
      _$UsersRequestFromJson(json);
}
