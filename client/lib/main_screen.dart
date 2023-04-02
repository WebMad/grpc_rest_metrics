import 'package:client/features/file/blocs/file_grpc/file_grpc_cubit.dart';
import 'package:client/features/file/blocs/file_rest/file_rest_cubit.dart';
import 'package:client/features/file/widgets/file_results.dart';
import 'package:client/features/greeting/blocs/greeting_grpc/greeting_grpc_cubit.dart';
import 'package:client/features/greeting/blocs/greeting_rest/greeting_rest_cubit.dart';
import 'package:client/features/greeting/widgets/greeting_results.dart';
import 'package:client/features/users/blocs/users_gprc/users_grpc_cubit.dart';
import 'package:client/features/users/blocs/users_rest/users_rest_cubit.dart';
import 'package:client/features/users/widgets/users_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => UsersGrpcCubit()),
                  BlocProvider(create: (context) => UsersRestCubit()),
                ],
                child: const UsersResults(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => GreetingGrpcCubit()),
                  BlocProvider(create: (context) => GreetingRestCubit()),
                ],
                child: const GreetingResults(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => FileGrpcCubit()),
                  BlocProvider(create: (context) => FileRestCubit()),
                ],
                child: const FileResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
