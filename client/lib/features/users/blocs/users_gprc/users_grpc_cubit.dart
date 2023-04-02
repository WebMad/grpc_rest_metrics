import 'dart:convert';

import 'package:client/common/app_settings.dart';
import 'package:client/common/test_case_result.dart';
import 'package:client/features/users/protos/users.pbgrpc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grpc/grpc.dart';

part 'users_grpc_cubit.freezed.dart';
part 'users_grpc_state.dart';

class UsersGrpcCubit extends Cubit<UsersGrpcState> {
  UsersGrpcCubit() : super(const UsersGrpcState.initial());

  startMeasurement() async {
    try {
      emit(const UsersGrpcState.loadingUsers());
      final users = (await _loadUsers()).sublist(0, 100);

      emit(UsersGrpcState.processing(usersCount: users.length));

      final channel = ClientChannel(
        AppSettings.host,
        port: AppSettings.grpcPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      final usersServiceClient = UsersServiceClient(channel);

      final List<TestCaseResult> testCaseResults = [];
      for (var usersLength = 10;
          usersLength <= users.length;
          usersLength += 10) {
        final usersToSend = users.sublist(0, usersLength);

        for (var i = 0; i < 100; i++) {
          final result = await _sendRequest(
            usersToSend,
            usersServiceClient,
          );
          testCaseResults.add(result);
        }
      }

      await channel.shutdown();

      emit(UsersGrpcState.done(
        usersCount: users.length,
        testCaseResults: testCaseResults,
      ));
    } catch (e) {
      emit(UsersGrpcState.error(msg: e.toString()));
    }
  }

  Future<TestCaseResult> _sendRequest(
      List<User> users, UsersServiceClient usersServiceClient) async {
    final request = GetUsersRequest(
      users: users,
      requestCreatedAt: DateTime.now().microsecondsSinceEpoch.toString(),
    );

    final response = await usersServiceClient.getUser(request);
    final responseAcceptedAt = DateTime.now().microsecondsSinceEpoch;

    final requestVolume = request.writeToBuffer().length;

    final responseVolume = response.writeToBuffer().length;

    return TestCaseResult(
      countRecords: response.count,
      requestVolumeInBytes: requestVolume,
      responseVolumeInBytes: responseVolume,
      requestTime: responseAcceptedAt - int.parse(response.requestCreatedAt),
    );
  }

  Future<List<User>> _loadUsers() async {
    return (json.decode(await rootBundle.loadString("assets/users.json"))
            as List<dynamic>)
        .map((e) {
      return User(
        id: UserId(
          name: e['id']['name'],
          value: e['id']['value'],
        ),
        gender: e['gender'],
        email: e['email'],
        location: Location(
          city: e['location']['city'],
          state: e['location']['state'],
          postcode: e['location']['postcode'],
          country: e['location']['country'],
          coordinates: Coordinates(
            latitude: e['location']['coordinates']['latitude'],
            longitude: e['location']['coordinates']['longitude'],
          ),
          street: Street(
            name: e['location']['street']['name'],
            number: e['location']['street']['number'],
          ),
          timezone: Timezone(
            description: e['location']['timezone']['description'],
            offset: e['location']['timezone']['offset'],
          ),
        ),
      );
    }).toList();
  }
}
