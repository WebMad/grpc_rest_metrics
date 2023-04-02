part of 'users_rest_cubit.dart';

@freezed
class UsersRestState with _$UsersRestState {
  const factory UsersRestState.initial() = _Initial;

  const factory UsersRestState.loadingUsers() = _LoadingUsers;

  const factory UsersRestState.processing({
    required int usersCount,
  }) = _Processing;

  const factory UsersRestState.error({
    required String msg,
  }) = _Error;

  const factory UsersRestState.done({
    required int usersCount,
    required List<TestCaseResult> testCaseResults,
  }) = _Done;
}
