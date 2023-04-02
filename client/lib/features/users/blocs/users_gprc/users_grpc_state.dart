part of 'users_grpc_cubit.dart';

@freezed
class UsersGrpcState with _$UsersGrpcState {
  const factory UsersGrpcState.initial() = _Initial;

  const factory UsersGrpcState.loadingUsers() = _LoadingUsers;

  const factory UsersGrpcState.processing({
    required int usersCount,
  }) = _Processing;

  const factory UsersGrpcState.error({
    required String msg,
  }) = _Error;

  const factory UsersGrpcState.done({
    required int usersCount,
    required List<TestCaseResult> testCaseResults,
  }) = _Done;
}
