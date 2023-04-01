import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:server/features/users/entities/location.dart';
import 'package:server/features/users/entities/user_id.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory User({
    required String gender,
    required Location location,
    required String email,
    required UserId id,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
